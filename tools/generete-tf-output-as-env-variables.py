import json

with open('./workspace/output.json') as outputFile:
    d = json.load(outputFile)
    for key in d.keys():
        #TODO Does Serverless understand list as inbound var? Need check and investigation.
        value = d[key]['value'][0] if key == 'subnet_ids' else d[key]['value']
        print("export {key}={value}".format(key=key, value=value))
