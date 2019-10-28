require_relative "../lib/pages/shutdown"
require "Minitest/autorun"
require "Minitest/pride"

class ShutDownTest < MiniTest::Test
  include ShutDown

  def test_it_displays_correct_count
    expected = ["Total Requests: 1", "exit"]
    actual  = shutdown(1)
    assert_equal expected, actual
  end
  
  def test_it_displays_new_count
    expected = ["Total Requests: 2", "exit"]
    actual  = shutdown(2)
    assert_equal expected, actual
  end

end
