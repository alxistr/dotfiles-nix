local function m(what, count)
    local result = {}
    for counter = 0, count or 9, 1 do
        result[counter] = what
    end
    return result
end

return {
    heaven=m('☰'),
    heaven2=m('≣'),
    arabic = { 1, 2, 3, 4, 5, 6, 7, 8, 9 },
    latin = { 'α', 'β', 'γ', 'δ', 'ε', 'ζ', 'η', 'θ', 'ι' },
    chinese = { "一", "二", "三", "四", "五", "六", "七", "八", "九" },
    traditional_chinese = { "壹", "貳", "叄", "肆", "伍", "陸", "柒", "捌", "玖" },
    east_arabic = { '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩', '١' },
    persian_arabic = { '٠', '١', '٢', '٣', '۴', '۵', '۶', '٧', '٨' },
    roman = { 'Ⅰ', 'Ⅱ', 'Ⅲ', 'Ⅳ', 'Ⅴ', 'Ⅵ', 'Ⅶ', 'Ⅷ', 'Ⅸ' },
    thai = { '๑', '๒', '๓', '๔', '๕', '๖', '๗', '๘', '๙' },
    round = m('◯'),
    peace = m('☮'),
    star = m('⛧'),
    cross = m('✜'),
    diamond_suit = m('◆'),
    filled_dot = m('⚫'),
    black_small_square = m('▪'),
    black_meduim_small_square = m('◾'),
}
