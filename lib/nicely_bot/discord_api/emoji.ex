defmodule DiscordApi.Emoji do
  alias Crux.Structs.Emoji

  def from_atom(:hit), do: %Emoji{id: 839_134_713_418_743_828, name: "hit"}
  def from_atom(:stay), do: %Emoji{id: 839_154_320_044_851_261, name: "stay"}
  def from_atom(:double), do: %Emoji{id: 839_154_333_302_915_073, name: "double"}

  def text_from_card("back"), do: "<:card_back:846410019620257853>"
  def text_from_card("As"), do: "<:card_as:846410095347630131>"
  def text_from_card("Ah"), do: "<:card_ah:846438029945602068>"
  def text_from_card("Ad"), do: "<:card_ad:846438030045872219>"
  def text_from_card("Ac"), do: "<:card_ac:846438029576503348>"
  def text_from_card("Ks"), do: "<:card_ks:846438029869449236>"
  def text_from_card("Kh"), do: "<:card_kh:846438030160035900>"
  def text_from_card("Kd"), do: "<:card_kd:846438029862240257>"
  def text_from_card("Kc"), do: "<:card_kc:846438029970898944>"
  def text_from_card("Qs"), do: "<:card_qs:846438029911523388>"
  def text_from_card("Qh"), do: "<:card_qh:846438029865254942>"
  def text_from_card("Qd"), do: "<:card_qd:846438029585416243>"
  def text_from_card("Qc"), do: "<:card_qc:846438029933019136>"
  def text_from_card("Js"), do: "<:card_js:846438029936558131>"
  def text_from_card("Jh"), do: "<:card_jh:846438029920960602>"
  def text_from_card("Jd"), do: "<:card_jd:846438029651869707>"
  def text_from_card("Jc"), do: "<:card_jc:846496790148546611>"
  def text_from_card("Ts"), do: "<:card_ts:846438030113636392>"
  def text_from_card("Th"), do: "<:card_th:846410095867723786>"
  def text_from_card("Td"), do: "<:card_td:846496918648782868>"
  def text_from_card("Tc"), do: "<:card_tc:846438029949665295>"
  def text_from_card("9s"), do: "<:card_9s:846438030024638555>"
  def text_from_card("9h"), do: "<:card_9h:846438029727105125>"
  def text_from_card("9d"), do: "<:card_9d:846438029916504114>"
  def text_from_card("9c"), do: "<:card_9c:846438029861847058>"
  def text_from_card("8s"), do: "<:card_8s:846438029844545586>"
  def text_from_card("8h"), do: "<:card_8h:846438029899071498>"
  def text_from_card("8d"), do: "<:card_8d:846438029856866334>"
  def text_from_card("8c"), do: "<:card_8c:846438029986889729>"
  def text_from_card("7s"), do: "<:card_7s:846438029656326175>"
  def text_from_card("7h"), do: "<:card_7h:846438029879279646>"
  def text_from_card("7d"), do: "<:card_7d:846438029848739850>"
  def text_from_card("7c"), do: "<:card_7c:846438029409124433>"
  def text_from_card("6s"), do: "<:card_6s:846438029823967232>"
  def text_from_card("6h"), do: "<:card_6h:846438029571915797>"
  def text_from_card("6d"), do: "<:card_6d:846410095855140885>"
  def text_from_card("6c"), do: "<:card_6c:846438029811253268>"
  def text_from_card("5s"), do: "<:card_5s:846438030021492736>"
  def text_from_card("5h"), do: "<:card_5h:846438029794869268>"
  def text_from_card("5d"), do: "<:card_5d:846438029866172426>"
  def text_from_card("5c"), do: "<:card_5c:846438029433765909>"
  def text_from_card("4s"), do: "<:card_4s:846438030079164467>"
  def text_from_card("4h"), do: "<:card_4h:846438029774422026>"
  def text_from_card("4d"), do: "<:card_4d:846438029790937118>"
  def text_from_card("4c"), do: "<:card_4c:846438029844938832>"
  def text_from_card("3s"), do: "<:card_3s:846438029774422076>"
  def text_from_card("3h"), do: "<:card_3h:846438029803388958>"
  def text_from_card("3d"), do: "<:card_3d:846438029928955954>"
  def text_from_card("3c"), do: "<:card_3c:846438029836156938>"
  def text_from_card("2s"), do: "<:card_2s:846438029995671552>"
  def text_from_card("2h"), do: "<:card_2h:846438029769179136>"
  def text_from_card("2d"), do: "<:card_2d:846438029782548480>"
  def text_from_card("2c"), do: "<:card_2c:846438029790674974>"

  # @card_back %Emoji{id: 846_410_019_620_257_853, name: "card_back"}
  # @card_as %Emoji{id: 846_410_095_347_630_131, name: "card_as"}
  # @card_ah %Emoji{id: 846_438_029_945_602_068, name: "card_ah"}
  # @card_ad %Emoji{id: 846_438_030_045_872_219, name: "card_ad"}
  # @card_ac %Emoji{id: 846_438_029_576_503_348, name: "card_ac"}
  # @card_ks %Emoji{id: 846_438_029_869_449_236, name: "card_ks"}
  # @card_kh %Emoji{id: 846_438_030_160_035_900, name: "card_kh"}
  # @card_kd %Emoji{id: 846_438_029_862_240_257, name: "card_kd"}
  # @card_kc %Emoji{id: 846_438_029_970_898_944, name: "card_kc"}
  # @card_qs %Emoji{id: 846_438_029_911_523_388, name: "card_qs"}
  # @card_qh %Emoji{id: 846_438_029_865_254_942, name: "card_qh"}
  # @card_qd %Emoji{id: 846_438_029_585_416_243, name: "card_qd"}
  # @card_qc %Emoji{id: 846_438_029_933_019_136, name: "card_qc"}
  # @card_js %Emoji{id: 846_438_029_936_558_131, name: "card_js"}
  # @card_jh %Emoji{id: 846_438_029_920_960_602, name: "card_jh"}
  # @card_jd %Emoji{id: 846_438_029_651_869_707, name: "card_jd"}
  # @card_jc %Emoji{id: 846_496_790_148_546_611, name: "card_jc"}
  # @card_ts %Emoji{id: 846_438_030_113_636_392, name: "card_ts"}
  # @card_th %Emoji{id: 846_410_095_867_723_786, name: "card_th"}
  # @card_td %Emoji{id: 846_496_918_648_782_868, name: "card_td"}
  # @card_tc %Emoji{id: 846_438_029_949_665_295, name: "card_tc"}
  # @card_9s %Emoji{id: 846_438_030_024_638_555, name: "card_9s"}
  # @card_9h %Emoji{id: 846_438_029_727_105_125, name: "card_9h"}
  # @card_9d %Emoji{id: 846_438_029_916_504_114, name: "card_9d"}
  # @card_9c %Emoji{id: 846_438_029_861_847_058, name: "card_9c"}
  # @card_8s %Emoji{id: 846_438_029_844_545_586, name: "card_8s"}
  # @card_8h %Emoji{id: 846_438_029_899_071_498, name: "card_8h"}
  # @card_8d %Emoji{id: 846_438_029_856_866_334, name: "card_8d"}
  # @card_8c %Emoji{id: 846_438_029_986_889_729, name: "card_8c"}
  # @card_7s %Emoji{id: 846_438_029_656_326_175, name: "card_7s"}
  # @card_7h %Emoji{id: 846_438_029_879_279_646, name: "card_7h"}
  # @card_7d %Emoji{id: 846_438_029_848_739_850, name: "card_7d"}
  # @card_7c %Emoji{id: 846_438_029_409_124_433, name: "card_7c"}
  # @card_6s %Emoji{id: 846_438_029_823_967_232, name: "card_6s"}
  # @card_6h %Emoji{id: 846_438_029_571_915_797, name: "card_6h"}
  # @card_6d %Emoji{id: 846_410_095_855_140_885, name: "card_6d"}
  # @card_6c %Emoji{id: 846_438_029_811_253_268, name: "card_6c"}
  # @card_5s %Emoji{id: 846_438_030_021_492_736, name: "card_5s"}
  # @card_5h %Emoji{id: 846_438_029_794_869_268, name: "card_5h"}
  # @card_5d %Emoji{id: 846_438_029_866_172_426, name: "card_5d"}
  # @card_5c %Emoji{id: 846_438_029_433_765_909, name: "card_5c"}
  # @card_4s %Emoji{id: 846_438_030_079_164_467, name: "card_4s"}
  # @card_4h %Emoji{id: 846_438_029_774_422_026, name: "card_4h"}
  # @card_4d %Emoji{id: 846_438_029_790_937_118, name: "card_4d"}
  # @card_4c %Emoji{id: 846_438_029_844_938_832, name: "card_4c"}
  # @card_3s %Emoji{id: 846_438_029_774_422_076, name: "card_3s"}
  # @card_3h %Emoji{id: 846_438_029_803_388_958, name: "card_3h"}
  # @card_3d %Emoji{id: 846_438_029_928_955_954, name: "card_3d"}
  # @card_3c %Emoji{id: 846_438_029_836_156_938, name: "card_3c"}
  # @card_2s %Emoji{id: 846_438_029_995_671_552, name: "card_2s"}
  # @card_2h %Emoji{id: 846_438_029_769_179_136, name: "card_2h"}
  # @card_2d %Emoji{id: 846_438_029_782_548_480, name: "card_2d"}
  # @card_2c %Emoji{id: 846_438_029_790_674_974, name: "card_2c"}
end
