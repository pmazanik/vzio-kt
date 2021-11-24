#!/bin/bash
# Based on https://gist.github.com/mjdietzx/6ec00ebd1223ca1cf87fa0c80e0bf84e
ASSET_FILE="${1}"
PRERELEASE="${2}"

RELEASE_URL="https://api.github.com/repos/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/releases"
RELEASE_NAME="${CIRCLE_PROJECT_REPONAME}_${BUILD_VERSION}"
RELEASE_JSON=$(jq -n \
      --arg version "${BUILD_VERSION}" \
      --arg branch "${CIRCLE_BRANCH}" \
      --arg name "${RELEASE_NAME}" \
      --arg prerelease "${PRERELEASE}" \
      '{tag_name: "v\($version)", target_commitish: $branch, name: $name, body: "Release of \($version) created from CircleCI.", draft: false, prerelease: ($prerelease != "false") }' )


echo
echo "Payload"
echo "${RELEASE_JSON}" | jq

RELEASE_RESPONSE=$(curl --silent --header "Authorization: token $GITHUB_TOKEN" --data "$RELEASE_JSON" "${RELEASE_URL}")
RELEASE_ID=$(echo "${RELEASE_RESPONSE}" | jq -r .id)

echo
echo "Response from ${RELEASE_URL}"
echo "${RELEASE_RESPONSE}" | jq
echo

# exit script if GitHub release was not successfully created
if [ "${RELEASE_ID}" == "null" ]
then
      echo "FAILED to create GitHub release!"
      exit 1
fi

echo "Release created with id: ${RELEASE_ID}, uploading assets"

# add artifacts to the release
ASSET_TARGET_URL="https://uploads.github.com/repos/${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}/releases/${RELEASE_ID}/assets?name=${ASSET_FILE}"
UPLOAD_RESPONSE=$(curl --silent --header "Authorization: token ${GITHUB_TOKEN}" --data-binary @"${ASSET_FILE}" -H "Content-Type: application/octet-stream" "${ASSET_TARGET_URL}")

echo 
echo "Upload complete"
echo "${UPLOAD_RESPONSE}" | jq
echo
echo "Release successful!"
exit 0
