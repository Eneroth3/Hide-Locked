module Eneroth::HideLocked

  ACTION_HIDE = "Hide (Despite Locked)"
  ACTION_UNHIDE = "Unhide (Despite Locked)"

  def self.add_menu_item(menu, name, position = nil, &block)
    if position && Sketchup.platform == :platform_win && Sketchup.version.to_i >= 16
      menu.add_item(name, position, &block)
    else
      menu.add_item(name, &block)
    end
  end

  def self.menu_index
    # Succeeds:
    #   Entity Info
    #   Erase
    #   Hide/Unhide (native)
    3
  end

  def self.hidden?
    Sketchup.active_model.selection.any? { |e| !e.visible? }
  end

  def self.menu_available?
    Sketchup.active_model.selection.any? { |e| e.respond_to?(:locked?) && e.locked? }
  end

  def self.hide
    model = Sketchup.active_model
    model.start_operation(ACTION_HIDE, true)
    model.selection.each { |e| e.hidden = true }
    model.commit_operation
    model.selection.clear
  end

  def self.unhide
    model = Sketchup.active_model
    model.start_operation(ACTION_UNHIDE, true)
    model.selection.each { |e| e.hidden = false }
    model.commit_operation
  end

  @loaded ||= false
  unless @loaded
    @loaded = true

    UI.add_context_menu_handler do |menu|
      next unless menu_available?
      if hidden?
        item = add_menu_item(menu, ACTION_UNHIDE, menu_index) { unhide }
      else
        item = add_menu_item(menu, ACTION_HIDE, menu_index) { hide }
      end
    end
  end

end
