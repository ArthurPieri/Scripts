# pip install qrcode python-dotenv Pillow

import qrcode
import os
from dotenv import load_dotenv
from pathlib import Path

def generate_qrcode():
  '''
  To create an qrcode you need to provide a file called .env.wifi with the following:
  - WIFI_NAME
  - WIFI_PASSWORD
  - WIFI_TYPE
  '''
  env_path = Path('./.wifi.env')
  load_dotenv(dotenv_path=env_path)

  wifi_name = os.getenv('WIFI_NAME')
  wifi_password = os.getenv('WIFI_PASSWORD')
  wifi_type=os.getenv('WIFI_TYPE')

  wifi_qrcode = qrcode.make('WIFI:T:' + wifi_type + ';S:' + wifi_name + ';P:' + wifi_password + ';;')

  wifi_qrcode.save(f'{wifi_name}_qrcode.png')

generate_qrcode()