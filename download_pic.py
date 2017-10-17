import re,os
import requests
if not os.path.exists('./Picture'):
    os.mkdir('./Picture')
img_num = 4438
for i in range(1,img_num+1):
    url = 'http://www.xkrjy.com/sy/img/'+str(i)+'.gif'
    try:
        pic = requests.get(url, timeout = 10)
        filename = './Picture/'+str(i)+'.gif'
        file = open(filename,'wb')
        file.write(pic.content)
        file.close()
    except  Exception, e:
        print url + e
        continue