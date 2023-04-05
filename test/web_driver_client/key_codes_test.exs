defmodule WebDriverClient.KeyCodesTest do
  use ExUnit.Case, async: true

  alias WebDriverClient.KeyCodes

  test "key_code_atoms_union/0 generates ast for the union of all of the key_code atoms" do
    assert KeyCodes.key_code_atoms_union() |> Macro.to_string() ==
             ":null\n| :cancel\n| :help\n| :backspace\n| :tab\n| :clear\n| :return\n| :enter\n| :shift\n| :left_shift\n| :control\n| :left_control\n| :alt\n| :left_alt\n| :pause\n| :escape\n| :space\n| :page_up\n| :page_down\n| :end\n| :home\n| :left\n| :arrow_left\n| :up\n| :arrow_up\n| :right\n| :arrow_right\n| :down\n| :arrow_down\n| :insert\n| :delete\n| :semicolon\n| :equals\n| :numpad0\n| :numpad1\n| :numpad2\n| :numpad3\n| :numpad4\n| :numpad5\n| :numpad6\n| :numpad7\n| :numpad8\n| :numpad9\n| :multiply\n| :add\n| :separator\n| :subtract\n| :decimal\n| :divide\n| :f1\n| :f2\n| :f3\n| :f4\n| :f5\n| :f6\n| :f7\n| :f8\n| :f9\n| :f10\n| :f11\n| :f12\n| :meta\n| :command\n| :left_meta\n| :right_shift\n| :right_control\n| :right_alt\n| :right_meta\n| :numpad_page_up\n| :numpad_page_down\n| :numpad_end\n| :numpad_home\n| :numpad_left\n| :numpad_up\n| :numpad_right\n| :numpad_down\n| :numpad_insert\n| :numpad_delete"
  end
end
