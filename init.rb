# -*- coding: utf-8 -*-

require 'redmine'
require 'redmine_utils_patch'

ActionDispatch::Callbacks.to_prepare do
  require_dependency 'redmine/utils'

  unless Redmine::Utils::DateCalculation.included_modules.include?(RedmineUtilsDateCalculationPatch)
    Redmine::Utils::DateCalculation.send :include, RedmineUtilsDateCalculationPatch
  end
end

Redmine::Plugin.register :rest_day do
  name 'Redmine Work Days'
  author 'Agileware Inc.'
  description ''
  version '0.9.0'
  url 'http://agileware.jp'
  author_url 'http://agileware.jp'

  menu :admin_menu, :rest_days, { :controller => 'rest_days', :action => 'index' }, :caption => :rest_days
end
