
class HomePage
  
  #TOP LINKS
  SIGNUP_LINK_ID  = "signupLink"
  LOGIN_LINK_ID   = "loginLink"
  START_YOUR_REGISTRY_LINK_ID = "createRegistryLink"
  REGISTRY_EDIT_URL = "https://qa.zola.com/registry"
  MY_ACCOUNT_LINK_XPATH = ".//*[@class='dropdown dropdown-hover with-arrow']//*[@href='/account/info']"
  CART_BUTTON_ID = "openCartLink"
  
  #Account sub-menu
  REGISTRY_SETTINGS_ID = "your-registry-menu-registry-settings"
  REGISTRY_SETTINGS_LINK_ID = "registrySettingsLink"
  LOG_OUT_LINK_ID = "account-menu-logout"
  
  
  #HEADER LINKS
  HOME_SHOP_XPATH = "(.//*[@href='/shop'])[1]"
  REGISTRY_LINK_XPATH = "(.//*[@href='/registry/oliviaandfitz/edit'])[2]"  
  BLOG_LINK_XPATH = "(.//*[@href='http://blog.zola.com/'])[2]"
  LOGO_ZOLA_XPATH = "(.//*[@class='logo'])[1]"
  REGISTRY_UNIVERSAL_BUTTON_XPATH = "(.//*[@target='_self'])[1]"
  
  #BODY
  MAKE_IT_VISIBLE_BUTTON = ".//*[@class='button red medium publish-registry-button']"
  COUPLE_NAME_DIV_ID = "editRegistryTitle"
  
  #this button is from page "looking for a registry?"
  FIND_REGISTRY_BUTTON_XPATH = ".//*[@class='button primary big']"
  
  #button displayed in a congratulation modal after you make a registry public
  ADD_WEDDING_WEB_BUTTON_XPATH = ".//*[@class='button medium primary full-width share-link']"
  
  #FOOTER LINKS
  
  EMAIL_FOOTER_LINK_XPATH = "(.//*[@class='cta-detail'])[1]"
  EDIT_REGISTRY_LINK_XPATH = "(.//*[@class='cta-detail'])[3]"
  FIND_REGISTRY_LINK_XPATH = "(.//*[@class='cta-detail'])[4]"
  DOWNLOAD_APPS_XPATH = "(.//*[@class='cta-detail'])[5]"
  REGISTRY_BENEFITS_ID = "footerLinkBenefits"
  ZOLA_SHOP_ID = "footerLinkShop"
  ABOUT_ZOLA_ID ="footerLinkAbout"
  PRESS_ID = "footerLinkPress"
  JOBS_ID = "footerLinkJobs"
  BLOG_ID = "FooterLinkBlog"
  FAQS_ID = "footerLinkFAQ"
  ORDER_STATUS_ID = "footerLinkOrderStatus"
  TWITTER_XPATH = ".//*[@class='social-icon twitter-lg']"
  FACEBOOK_XPATH = ".//*[@class='social-icon facebook-lg']"
  PINTEREST_XPATH = ".//*[@class='social-icon pinterest-lg']"
  INSTAGRAM_XPATH = ".//*[@class='social-icon instagram-lg']"
  GOOGLE_PLUS_XPATH = ".//*[@class='social-icon googleplus-lg']"
  TERMS_SERVICE_ID = "footerLinkTermsOfService"
  PRIVACY_POLICY_ID = "footerLinkPrivacyPolicy"
  
  #URL LINK CONTROL
  
  HOME_URL = "https://qa.zola.com"
  REGISTRY_URL = "https://qa.zola.com/registry/juanandjulisa/edit"
  FIND_REGISTRY_URL = "https://qa.zola.com/find-registry"
  DOWNLOAD_APPS_URL = "https://qa.zola.com/simplify"
  REGISTRY_BENEFITS_URL = "https://qa.zola.com/registry/benefits"
  ZOLA_SHOP_URL = "https://qa.zola.com/shop/index"
  ABOUT_ZOLA_URL = "https://qa.zola.com/about/index"
  PRESS_URL = "https://qa.zola.com/about/press"
  JOBS_URL = "https://qa.zola.com/about/jobs"
  BLOG_URL = "http://blog.zola.com/"
  FAQS_URL = "https://qa.zola.com/help"
  ORDER_STATUS_URL = "https://qa.zola.com/account/orders"
  TWITTER_URL = "https://twitter.com/zolaregistry"
  FACEBOOK_URL = "https://www.facebook.com/zolaregistry"
  PINTEREST_URL = "https://www.pinterest.com/zolaregistry/"
  INSTAGRAM_URL1 = "http://instagram.com/zolaregistry/"
  INSTAGRAM_URL2 = "https://instagram.com/zolaregistry/"
  GOOGLE_PLUS_URL = "https://plus.google.com/116442943345722651304/about"
  TERMS_SERVICE_URL = "https://qa.zola.com/terms"
  PRIVACY_POLICY_URL = "https://qa.zola.com/privacy"

  #ITEMS FROM OTHER PAGES
  TWITTER_PROFILE_IMAGE_XPATH = ".//*[@class='ProfileAvatar']"
  FACEBOOK_PROFILE_IMAGE_XPATH = ".//*[@class='profilePic img']"
  GOOGLE_PLUS_PROFILE_IMAGE_XPATH = ".//*[@class='dkb photo']"
  INSTAGRAM_PROFILE_IMAGE_XPATH = ".//*[@class='-cx-PRIVATE-ProfilePage__avatar']"
  PINTEREST_PROFILE_IMAGE_XPATH = ".//*[@class='profileImage']"
  BLOG_HEADER_ID = "site-header"
  
  #EXTRA URL
  
  MARKETING_SERVICE_URL = "https://qa.zola.com/marketing_service_terms"
  VENDOR_TERMS_URL = "https://qa.zola.com/vendor_terms"
  
  MARKETING_SERVICE_TEXT_XPATH = ".//*[@class='title']"
  MARKETING_SERVICE_TEXT_WORDS = "Marketing Service Terms"
  VENDOR_TERMS_TEXT_XPATH = ".//*[@class='page-header']"
  VENDOR_TERMS_TEXT_WORDS = "Supplemental Vendor Terms and Conditions"
end