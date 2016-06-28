#==============================================================================
# * Error Details:
# I added a BG image for message boxes, but whenever using the choice prompt, 
# the choice box is sometimes hidden underneath the image.
#---------------------------------------------------------------------------
# Script Call: 
#-------------
# Window_ChoiceList.alt_align( newalign )
# 
# 'newalign' should be an integer value (0,1, or 2) that determines the 
# alignment of the choice winow when its shown. 
#==============================================================================
module DekChoicesFix 
  #--------------------------------------------------------------------------
  # Sets the default alignment of the choice window. 
  # Alignment sets the text and window position.
  # 0 = window at the left of the screen with text at the left side of window.
  # 1 = window at the center of the screen with text at the center of window.
  # 2 = window at the right of the screen with text at the right side of window.
  #--------------------------------------------------------------------------
  Alignment = 1
   
  #--------------------------------------------------------------------------
  # Sts teh z vallue (importance) of the window. 
  #--------------------------------------------------------------------------
  Window_Z = 200
   
  #=============================================================================
  # ? CUSTOMIZATION SECTION HAS FINISHED. 
  #=============================================================================
end
 
#==============================================================================
# ¦ Window_ChoiceList
#------------------------------------------------------------------------------
# This window is used for the event command [Show Choices].
#==============================================================================
class Window_ChoiceList 
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  alias :choicelistfixbydekita :initialize
  def initialize(*argz,&blawk)
    choicelistfixbydekita(*argz,&blawk)
    send('z=',DekChoicesFix::Window_Z)
  end
  #--------------------------------------------------------------------------
  # Default alignment. 0 = left, 1 = center, 2 = right. 
  # NOTE: Window position is also affected. 
  #--------------------------------------------------------------------------
  @@alignment  = DekChoicesFix::Alignment 
  #--------------------------------------------------------------------------
  # Script call to set alignment:
  # Window_ChoiceList.alt_align( newalign )
  #--------------------------------------------------------------------------
  def self.alt_align(newalign = 1)
    @@alignment = newalign
  end
  #--------------------------------------------------------------------------
  # Alias for select to allow for refreshing the page on select. 
  #--------------------------------------------------------------------------
  alias :selectfixbydekita :select
  def select(*args, &blawk)
    selectfixbydekita(*args, &blawk);refresh()
  end
  #--------------------------------------------------------------------------
  # Draws the 'item' (choice text) into the window. 
  #--------------------------------------------------------------------------
  def draw_item(index)
    refresh_window_alignment
    r = item_rect_for_text(index)
    a = [r.x, r.y, r.width, r.height]
    n = command_name(index)
    if self.index == index 
      n = '[' + n + ']'
    end
    draw_text(*a, n, @@alignment)
  end
  #--------------------------------------------------------------------------
  # Refreshess the window position if changed. 
  #--------------------------------------------------------------------------
  def refresh_window_alignment
    self.x = case @@alignment
    when 0 then 0
    when 1 then Graphics.width/2-(width/2)
    when 2 then Graphics.width-width
    end
  end
  #--------------------------------------------------------------------------
  # Update Window Position
  #--------------------------------------------------------------------------
  alias :update_placementdekifix :update_placement
  def update_placement(*argz, &blawk)
    update_placementdekifix(*argz, &blawk)
    self.width = Graphics.width
    self.x = Graphics.width - width
  end
  #--------------------------------------------------------------------------
  # End Class
  #--------------------------------------------------------------------------
end
