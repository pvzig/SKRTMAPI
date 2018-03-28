Pod::Spec.new do |s|
  s.name                    = "SKRTMAPI"
  s.version                 = "4.1.2"
  s.summary                 = "A Swift library for connecting to the Slack RTM API"
  s.homepage                = "https://github.com/SlackKit/SKRTMAPI"
  s.license                 = 'MIT'
  s.author                  = { "Peter Zignego" => "peter@launchsoft.co" }
  s.source                  = { :git => "https://github.com/SlackKit/SKRTMAPI.git", :tag => s.version.to_s }
  s.social_media_url        = 'https://twitter.com/pvzig'
  s.ios.deployment_target   = '9.0'
  s.osx.deployment_target   = '10.11'
  s.tvos.deployment_target  = '9.0'
  s.requires_arc            = true
  s.source_files            = 'Sources/**/*.swift'  
  s.frameworks              = 'Foundation'
  s.dependency                'SKCore'
  s.dependency                'SKWebAPI'
  s.dependency                'Starscream'
end
