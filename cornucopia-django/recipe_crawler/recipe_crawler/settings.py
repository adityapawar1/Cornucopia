from shutil import which
from platform import platform
import os.path
# Scrapy settings for recipe_crawler project
#
# For simplicity, this file contains only settings considered important or
# commonly used. You can find more settings consulting the documentation:
#
#     https://docs.scrapy.org/en/latest/topics/settings.html
#     https://docs.scrapy.org/en/latest/topics/downloader-middleware.html
#     https://docs.scrapy.org/en/latest/topics/spider-middleware.html
import sys
sys.path.append('/Users/adityapawar/Documents/GitHub/Cornucopia/cornucopia-django')

import os
os.environ['DJANGO_SETTINGS_MODULE'] = 'cornucopia.settings'

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()

BOT_NAME = 'recipe_crawler'

SPIDER_MODULES = ['recipe_crawler.spiders']
NEWSPIDER_MODULE = 'recipe_crawler.spiders'

SPLASH_URL = 'http://54.215.157.199:8050/'

DUPEFILTER_CLASS = 'scrapy_splash.SplashAwareDupeFilter'
HTTPCACHE_STORAGE = 'scrapy_splash.SplashAwareFSCacheStorage'


# SELENIUM_DRIVER_NAME = 'chrome'
# if 'Linux' in platform():
#     print('linux system detected')
#     SELENIUM_DRIVER_EXECUTABLE_PATH = which('chromedriver')
# else:
#     SELENIUM_DRIVER_EXECUTABLE_PATH = '/Users/adityapawar/Documents/chromedriver'

# # SELENIUM_COMMAND_EXECUTOR = which('chromedriver')
# SELENIUM_DRIVER_ARGUMENTS=['--no-sandbox', '--headless'] 


# Crawl responsibly by identifying yourself (and your website) on the user-agent
#USER_AGENT = 'recipe_crawler (+http://www.yourdomain.com)'

# Obey robots.txt rules
ROBOTSTXT_OBEY = False

# Configure maximum concurrent requests performed by Scrapy (default: 16)
#CONCURRENT_REQUESTS = 32

# Configure a delay for requests for the same website (default: 0)
# See https://docs.scrapy.org/en/latest/topics/settings.html#download-delay
# See also autothrottle settings and docs
#DOWNLOAD_DELAY = 3
# The download delay setting will honor only one of:
#CONCURRENT_REQUESTS_PER_DOMAIN = 16
#CONCURRENT_REQUESTS_PER_IP = 16

# Disable cookies (enabled by default)
#COOKIES_ENABLED = False

# Disable Telnet Console (enabled by default)
#TELNETCONSOLE_ENABLED = False

# Override the default request headers:
#DEFAULT_REQUEST_HEADERS = {
#   'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
#   'Accept-Language': 'en',
#}

# Enable or disable spider middlewares
# See https://docs.scrapy.org/en/latest/topics/spider-middleware.html
SPIDER_MIDDLEWARES = {
#    'recipe_crawler.middlewares.RecipeCrawlerSpiderMiddleware': 543,
    # 'scrapy_splash.SplashDeduplicateArgsMiddleware': 100,

}

# Enable or disable downloader middlewares
# See https://docs.scrapy.org/en/latest/topics/downloader-middleware.html
DOWNLOADER_MIDDLEWARES = {
#    'recipe_crawler.middlewares.RecipeCrawlerDownloaderMiddleware': 543,
    'scrapy_splash.SplashMiddleware': 725,
    'scrapy.downloadermiddlewares.httpcompression.HttpCompressionMiddleware': 810
    # 'scrapy_selenium.SeleniumMiddleware': 800
}

# Enable or disable extensions
# See https://docs.scrapy.org/en/latest/topics/extensions.html
#EXTENSIONS = {
#    'scrapy.extensions.telnet.TelnetConsole': None,
#}

# Configure item pipelines
# See https://docs.scrapy.org/en/latest/topics/item-pipeline.html
ITEM_PIPELINES = {
   'recipe_crawler.pipelines.RecipeCrawlerPipeline': 300,
}

# Enable and configure the AutoThrottle extension (disabled by default)
# See https://docs.scrapy.org/en/latest/topics/autothrottle.html
#AUTOTHROTTLE_ENABLED = True
# The initial download delay
#AUTOTHROTTLE_START_DELAY = 5
# The maximum download delay to be set in case of high latencies
#AUTOTHROTTLE_MAX_DELAY = 60
# The average number of requests Scrapy should be sending in parallel to
# each remote server
#AUTOTHROTTLE_TARGET_CONCURRENCY = 1.0
# Enable showing throttling stats for every response received:
#AUTOTHROTTLE_DEBUG = False

# Enable and configure HTTP caching (disabled by default)
# See https://docs.scrapy.org/en/latest/topics/downloader-middleware.html#httpcache-middleware-settings
#HTTPCACHE_ENABLED = True
#HTTPCACHE_EXPIRATION_SECS = 0
#HTTPCACHE_DIR = 'httpcache'
#HTTPCACHE_IGNORE_HTTP_CODES = []
#HTTPCACHE_STORAGE = 'scrapy.extensions.httpcache.FilesystemCacheStorage'
