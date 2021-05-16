# Backend installation

## Install python dependencies
```bash
pip install -r requirements.txt
```

## Install chrome, chromedriver for selenium
### Install chrome on Linux
```bash
sudo apt-get update
sudo apt-get install -y unzip xvfb libxi6 libgconf-2-4
sudo curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
sudo echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
sudo apt-get -y update
sudo apt-get -y install google-chrome-stable
```

### Install chromedriver
you can find chromedriver version for your os and chrome version in here: https://chromedriver.chromium.org/
get the download link, and use wget to download it:
```bash
wget https://chromedriver.storage.googleapis.com/90.0.4430.24/chromedriver_linux64.zip
```
then unzip it:
```bash
unzip chromedriver_linux64.zip
sudo chmod +x chromedriver
```

## Run it!
```bash
uvicorn main:app --host 127.0.0.1 --port 8000 --reload # --reload if you want hot reloading
```