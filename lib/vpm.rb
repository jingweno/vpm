require 'fileutils'

require 'vpm/version'
require 'vpm/manifest_parser'
require 'vpm/plugin'
require 'vpm/plugins'
require 'vpm/git'
require 'vpm/runner'

# options
require 'vpm/command_options'
require 'vpm/command_options/install'

# commands
require 'vpm/commands/install'

module VPM
  def self.plugins
    @plugins ||= Plugins.load_from_file(plugins_file)
  end

  def self.vim_dir
    @vim_dir_path ||= begin
                        dir_path = ENV['VPM_VIM_DIR'] ? File.expand_path(ENV['VPM_VIM_DIR']) : File.join(ENV['HOME'], '.vim')
                        FileUtils.mkdir_p dir_path unless Dir.exists?(dir_path)
                        dir_path
                      end
  end

  def self.plugin_dir
    @plugin_dir_path ||= begin
                           dir_path = File.join(vim_dir, 'bundle')
                           FileUtils.mkdir_p dir_path unless Dir.exists?(dir_path)
                           dir_path
                         end
  end

  def self.plugins_file
    @insatlled_plugins_file ||= begin
                                  vpm_dir_path = File.join(vim_dir, 'vpm')
                                  FileUtils.mkdir_p vpm_dir_path unless Dir.exists?(vpm_dir_path)

                                  plugins_file_path = File.join(vpm_dir_path, 'plugins.yaml')
                                  FileUtils.touch(plugins_file_path)
                                  plugins_file_path
                                end
  end
end
