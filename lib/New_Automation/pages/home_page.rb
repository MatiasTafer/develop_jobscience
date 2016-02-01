class HomePage
  
  #TOP LINKS
  LOGIN_LINK_ID   = "loginLink"
  MY_ACCOUNT_LINK_XPATH = ".//*[@class='dropdown dropdown-hover with-arrow']/a"
  
  #Account sub-menu
  REGISTRY_SETTINGS_ID = "your-registry-menu-registry-settings"
  REGISTRY_SETTINGS_LINK_ID = "registrySettingsLink"
  LOG_OUT_LINK_ID = "account-menu-logout"
  
  
  #HEADER LINKS
  HOME_SHOP_XPATH = "(.//*[@href='/shop'])[1]"
  REGISTRY_LINK_XPATH = ".//*[@id='collapsed-registry-nav']//*[@id='editRegistryLink']"  
  BLOG_LINK_XPATH = "(.//*[@href='http://blog.zola.com/'])[2]"
  LOGO_ZOLA_XPATH = "(.//*[@class='logo'])[1]"
  REGISTRY_UNIVERSAL_BUTTON_XPATH = "(.//*[@target='_self'])[1]"
  
end