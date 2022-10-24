# pip install requests-html

import sys
from requests_html import HTMLSession

def Get_Webpage(url):
    session = HTMLSession()
    response = session.get(url)
    response.html.render(sleep=2)
    # TODO save page to a folder
    return response.html

Get_Webpage(sys.argv[1])