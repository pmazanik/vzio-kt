import json
import os
import sys
import re
from datetime import datetime

regex = r"(\d+)\.(\d+)\.(\d)"
with open('./package.json') as packageFile:
    d = json.load(packageFile)
    matches = re.search(regex, d['version'])
    print ('export BUILD_VERSION=' + matches.group(1) + '.' + matches.group(2) + '.' + matches.group(3) + '.' + datetime.now().strftime('%y%U') + os.environ['CIRCLE_BUILD_NUM'] + '-' + os.environ['STAGE'] + '-' + os.environ['PIPELINE_NUMBER'])
