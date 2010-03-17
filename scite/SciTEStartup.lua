function tag(id)
	local endtag = string.sub(id, 1, (string.find(id, '%s') or 0) - 1)
	local sel = editor:GetSelText()
	editor:ReplaceSel('<' .. id .. '>' .. sel .. '</' .. endtag .. '>')
	if sel == '' then
		editor:SetSel(editor.SelectionEnd - string.len(sel) - string.len(endtag) - 3, editor.SelectionEnd - string.len(endtag) - 3)
	end
end

function input_checkbox(id)
	local sel = editor:GetSelText()
	editor:ReplaceSel('<label for="' .. id .. '"><input type="checkbox" name="' .. id .. '" id="' .. id .. '" value="1" />' .. sel .. '</label>')
	editor:SetSel(editor.SelectionEnd - string.len(sel) - 8, editor.SelectionEnd - 8)
end

function input_radio(id)
	local sel = editor:GetSelText()
	editor:ReplaceSel('<label for="' .. id .. '"><input type="radio" name="' .. string.sub(id, 1, string.find(id, '-') - 1) .. '" id="' .. id .. '" value="' .. string.sub(id, string.find(id, '-') + 1) .. '" />' .. sel .. '</label>')
	editor:SetSel(editor.SelectionEnd - string.len(sel) - 8, editor.SelectionEnd - 8)
end

function htmlspecialchars()
	local sel = editor:GetSelText()
	editor:ReplaceSel(string.gsub(sel, '[<>&]', { ['<'] = '&lt;', ['>'] = '&gt;', ['&'] = '&amp;' }))
end

function link_php_function(f)
	editor:ReplaceSel('<a href="http://www.php.net/manual/en/function.' .. string.gsub(f, '_', '-') .. '.php"><kbd>' .. f .. '</kbd></a>')
end

function addslashes()
	editor:ReplaceSel('" . addslashes(' .. string.gsub(editor:GetSelText(), '(.+)%[(.+)%]', '%1["%2%"]') .. ') . "')
end

function sql_join(args)
	local pos1 = string.find(args, '%s')
	local pos2 = string.find(args, '%s', pos1+1)
	local join = string.sub(args, 1, pos1 - 1)
	local tab = string.sub(args, pos1 + 1, pos2 - 1)
	local col = string.sub(args, pos2 + 1)
	local sel = editor:GetSelText()
	local indent = editor.LineIndentation[editor:LineFromPosition(editor.CurrentPos)] / editor.TabWidth
	editor:ReplaceSel(sel .. '\n' .. string.rep('\t', indent) .. join .. ' JOIN ' .. tab .. ' ON ' .. string.sub(sel, 1, (string.find(sel, '%s') or 0) - 1) .. '.' .. col .. ' = ' .. string.sub(tab, (string.find(tab, '[.]') or 0) + 1) .. '.id')
end
