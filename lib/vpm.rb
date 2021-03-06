require 'fileutils'

require 'vpm/core'
require 'vpm/core/plugin'
require 'vpm/core/plugins'
require 'vpm/core/manifest_parser'

require 'vpm/command_options'
require 'vpm/commands'

require 'vpm/runner'
require 'vpm/utils/git'
require 'vpm/version'

module VPM
  def self.plugins
    @plugins ||= Core::Plugins.load_from_file(plugins_file_path)
  end

  def self.vim_dir_path
    @vim_dir_path ||= begin
                        dir_path = ENV['VPM_VIM_DIR'] ? File.expand_path(ENV['VPM_VIM_DIR']) : File.join(ENV['HOME'], '.vim')
                        FileUtils.mkdir_p dir_path unless Dir.exists?(dir_path)
                        dir_path
                      end
  end

  def self.bundle_dir_path
    @bundle_dir_path ||= begin
                           dir_path = File.join(vim_dir_path, 'bundle')
                           FileUtils.mkdir_p dir_path unless Dir.exists?(dir_path)
                           dir_path
                         end
  end

  def self.vim_plugins_manifest_path
    File.join(File.expand_path('.'), 'VimPlugins')
  end

  def self.plugins_file_path
    @insatlled_plugins_file ||= begin
                                  dir_path = File.join(vim_dir_path, 'vpm')
                                  FileUtils.mkdir_p dir_path unless Dir.exists?(dir_path)

                                  plugins_file_path = File.join(dir_path, 'plugins.yaml')
                                  FileUtils.touch(plugins_file_path)
                                  plugins_file_path
                                end
  end

  def self.vpmrc_path
    @vpmrc_path ||= File.join(vim_dir_path, '.vpmrc')
  end

  def self.vimrc_path
    @vimrc_path ||= File.join(ENV['HOME'], ".vimrc")
  end
end
