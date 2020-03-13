import requests
from datetime import datetime

print('Script has been started at {}'.format(datetime.now()))

resp = requests.get('https://google.com')
print(resp)

print('Script has been ended at {}'.format(datetime.now()))
