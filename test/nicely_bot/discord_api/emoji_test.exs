defmodule DiscordApi.EmojiTest do
  use ExUnit.Case, async: true

  alias DiscordApi.Emoji

  describe "emoji_for_option/1" do
    test "returns hit emoji" do
      emoji = Emoji.from_atom(:hit)
      assert 839_134_713_418_743_828 == emoji.id, "Hit emoji Discord Id incorrect"
      assert "hit" == emoji.name, "Hit emoji should be named hit"
    end

    test "returns stay emoji" do
      emoji = Emoji.from_atom(:stay)
      assert 839_154_320_044_851_261 == emoji.id, "Stay emoji Discord Id incorrect"
      assert "stay" == emoji.name, "Stay emoji should be named stay"
    end

    test "returns double emoji" do
      emoji = Emoji.from_atom(:double)
      assert 839_154_333_302_915_073 == emoji.id, "Double emoji Discord Id incorrect"
      assert "double" == emoji.name, "Double emoji should be named double"
    end

    test "returns <:card_back:846410019620257853> from back" do
      assert "<:card_back:846410019620257853>" == Emoji.text_from_card("back")
    end

    test "returns <:card_as:846410095347630131> from As" do
      assert "<:card_as:846410095347630131>" == Emoji.text_from_card("As")
    end

    test "returns <:card_ah:846438029945602068> from Ah" do
      assert "<:card_ah:846438029945602068>" == Emoji.text_from_card("Ah")
    end

    test "returns <:card_ad:846438030045872219> from Ad" do
      assert "<:card_ad:846438030045872219>" == Emoji.text_from_card("Ad")
    end

    test "returns <:card_ac:846438029576503348> from Ac" do
      assert "<:card_ac:846438029576503348>" == Emoji.text_from_card("Ac")
    end

    test "returns <:card_ks:846438029869449236> from Ks" do
      assert "<:card_ks:846438029869449236>" == Emoji.text_from_card("Ks")
    end

    test "returns <:card_kh:846438030160035900> from Kh" do
      assert "<:card_kh:846438030160035900>" == Emoji.text_from_card("Kh")
    end

    test "returns <:card_kd:846438029862240257> from Kd" do
      assert "<:card_kd:846438029862240257>" == Emoji.text_from_card("Kd")
    end

    test "returns <:card_kc:846438029970898944> from Kc" do
      assert "<:card_kc:846438029970898944>" == Emoji.text_from_card("Kc")
    end

    test "returns <:card_qs:846438029911523388> from Qs" do
      assert "<:card_qs:846438029911523388>" == Emoji.text_from_card("Qs")
    end

    test "returns <:card_qh:846438029865254942> from Qh" do
      assert "<:card_qh:846438029865254942>" == Emoji.text_from_card("Qh")
    end

    test "returns <:card_qd:846438029585416243> from Qd" do
      assert "<:card_qd:846438029585416243>" == Emoji.text_from_card("Qd")
    end

    test "returns <:card_qc:846438029933019136> from Qc" do
      assert "<:card_qc:846438029933019136>" == Emoji.text_from_card("Qc")
    end

    test "returns <:card_js:846438029936558131> from Js" do
      assert "<:card_js:846438029936558131>" == Emoji.text_from_card("Js")
    end

    test "returns <:card_jh:846438029920960602> from Jh" do
      assert "<:card_jh:846438029920960602>" == Emoji.text_from_card("Jh")
    end

    test "returns <:card_jd:846438029651869707> from Jd" do
      assert "<:card_jd:846438029651869707>" == Emoji.text_from_card("Jd")
    end

    test "returns <:card_jc:846496790148546611> from Jc" do
      assert "<:card_jc:846496790148546611>" == Emoji.text_from_card("Jc")
    end

    test "returns <:card_ts:846438030113636392> from Ts" do
      assert "<:card_ts:846438030113636392>" == Emoji.text_from_card("Ts")
    end

    test "returns <:card_th:846410095867723786> from Th" do
      assert "<:card_th:846410095867723786>" == Emoji.text_from_card("Th")
    end

    test "returns <:card_td:846496918648782868> from Td" do
      assert "<:card_td:846496918648782868>" == Emoji.text_from_card("Td")
    end

    test "returns <:card_tc:846438029949665295> from Tc" do
      assert "<:card_tc:846438029949665295>" == Emoji.text_from_card("Tc")
    end

    test "returns <:card_9s:846438030024638555> from 9s" do
      assert "<:card_9s:846438030024638555>" == Emoji.text_from_card("9s")
    end

    test "returns <:card_9h:846438029727105125> from 9h" do
      assert "<:card_9h:846438029727105125>" == Emoji.text_from_card("9h")
    end

    test "returns <:card_9d:846438029916504114> from 9d" do
      assert "<:card_9d:846438029916504114>" == Emoji.text_from_card("9d")
    end

    test "returns <:card_9c:846438029861847058> from 9c" do
      assert "<:card_9c:846438029861847058>" == Emoji.text_from_card("9c")
    end

    test "returns <:card_8s:846438029844545586> from 8s" do
      assert "<:card_8s:846438029844545586>" == Emoji.text_from_card("8s")
    end

    test "returns <:card_8h:846438029899071498> from 8h" do
      assert "<:card_8h:846438029899071498>" == Emoji.text_from_card("8h")
    end

    test "returns <:card_8d:846438029856866334> from 8d" do
      assert "<:card_8d:846438029856866334>" == Emoji.text_from_card("8d")
    end

    test "returns <:card_8c:846438029986889729> from 8c" do
      assert "<:card_8c:846438029986889729>" == Emoji.text_from_card("8c")
    end

    test "returns <:card_7s:846438029656326175> from 7s" do
      assert "<:card_7s:846438029656326175>" == Emoji.text_from_card("7s")
    end

    test "returns <:card_7h:846438029879279646> from 7h" do
      assert "<:card_7h:846438029879279646>" == Emoji.text_from_card("7h")
    end

    test "returns <:card_7d:846438029848739850> from 7d" do
      assert "<:card_7d:846438029848739850>" == Emoji.text_from_card("7d")
    end

    test "returns <:card_7c:846438029409124433> from 7c" do
      assert "<:card_7c:846438029409124433>" == Emoji.text_from_card("7c")
    end

    test "returns <:card_6s:846438029823967232> from 6s" do
      assert "<:card_6s:846438029823967232>" == Emoji.text_from_card("6s")
    end

    test "returns <:card_6h:846438029571915797> from 6h" do
      assert "<:card_6h:846438029571915797>" == Emoji.text_from_card("6h")
    end

    test "returns <:card_6d:846410095855140885> from 6d" do
      assert "<:card_6d:846410095855140885>" == Emoji.text_from_card("6d")
    end

    test "returns <:card_6c:846438029811253268> from 6c" do
      assert "<:card_6c:846438029811253268>" == Emoji.text_from_card("6c")
    end

    test "returns <:card_5s:846438030021492736> from 5s" do
      assert "<:card_5s:846438030021492736>" == Emoji.text_from_card("5s")
    end

    test "returns <:card_5h:846438029794869268> from 5h" do
      assert "<:card_5h:846438029794869268>" == Emoji.text_from_card("5h")
    end

    test "returns <:card_5d:846438029866172426> from 5d" do
      assert "<:card_5d:846438029866172426>" == Emoji.text_from_card("5d")
    end

    test "returns <:card_5c:846438029433765909> from 5c" do
      assert "<:card_5c:846438029433765909>" == Emoji.text_from_card("5c")
    end

    test "returns <:card_4s:846438030079164467> from 4s" do
      assert "<:card_4s:846438030079164467>" == Emoji.text_from_card("4s")
    end

    test "returns <:card_4h:846438029774422026> from 4h" do
      assert "<:card_4h:846438029774422026>" == Emoji.text_from_card("4h")
    end

    test "returns <:card_4d:846438029790937118> from 4d" do
      assert "<:card_4d:846438029790937118>" == Emoji.text_from_card("4d")
    end

    test "returns <:card_4c:846438029844938832> from 4c" do
      assert "<:card_4c:846438029844938832>" == Emoji.text_from_card("4c")
    end

    test "returns <:card_3s:846438029774422076> from 3s" do
      assert "<:card_3s:846438029774422076>" == Emoji.text_from_card("3s")
    end

    test "returns <:card_3h:846438029803388958> from 3h" do
      assert "<:card_3h:846438029803388958>" == Emoji.text_from_card("3h")
    end

    test "returns <:card_3d:846438029928955954> from 3d" do
      assert "<:card_3d:846438029928955954>" == Emoji.text_from_card("3d")
    end

    test "returns <:card_3c:846438029836156938> from 3c" do
      assert "<:card_3c:846438029836156938>" == Emoji.text_from_card("3c")
    end

    test "returns <:card_2s:846438029995671552> from 2s" do
      assert "<:card_2s:846438029995671552>" == Emoji.text_from_card("2s")
    end

    test "returns <:card_2h:846438029769179136> from 2h" do
      assert "<:card_2h:846438029769179136>" == Emoji.text_from_card("2h")
    end

    test "returns <:card_2d:846438029782548480> from 2d" do
      assert "<:card_2d:846438029782548480>" == Emoji.text_from_card("2d")
    end

    test "returns <:card_2c:846438029790674974> from 2c" do
      assert "<:card_2c:846438029790674974>" == Emoji.text_from_card("2c")
    end
  end
end
