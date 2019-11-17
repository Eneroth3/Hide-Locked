#-------------------------------------------------------------------------------
#
#    Author: Julia Christina Eneroth (eneroth3@gmail.com)
# Copyright: Copyright (c) 2017
#   License: MIT
#
#-------------------------------------------------------------------------------

require "sketchup.rb"
require "extensions.rb"

module Eneroth
  module HideLocked

    PLUGIN_ID = File.basename(__FILE__, ".rb")
    PLUGIN_DIR = File.join(File.dirname(__FILE__), PLUGIN_ID)

    EXTENSION = SketchupExtension.new(
      "Eneroth Hide/Unhide Locked",
      File.join(PLUGIN_DIR, "main")
    )
    EXTENSION.creator     = "Julia Christina Eneroth"
    EXTENSION.description = "Toggle visibility state on locked entities."
    EXTENSION.version     = "1.0.0"
    EXTENSION.copyright   = "#{EXTENSION.creator} 2017"
    Sketchup.register_extension(EXTENSION, true)

  end
end
