def duplicate_part(value_str)
  part_input = @browser.input(value: value_str)
  part_id_str = part_input.id.scan(/\d+/).first
  part_link = @browser.link(onclick: /#{part_id_str}/, class: nil)
  part_link.focus
  part_link.hover
  part_link.click
end

def rename_part(value_str, new_value_str)
  part_input = @browser.inputs(value: value_str).last
  part_input.focus
  part_input.set(new_value_str)
end

duplicate_part('Top')
duplicate_part('Bottom')
duplicate_part('Left')
duplicate_part('Right')
duplicate_part('Horiz. mid rail')
duplicate_part('Vert. mid rail')

rename_part('Top', 'Salvador Top Rail')
rename_part('Bottom', 'Salvador Bottom Rail')
rename_part('Left', 'Salvador Left Stile')
rename_part('Right', 'Salvador Right Stile')
rename_part('Horiz. mid rail', 'Salvador Horizontal Mid Rail')
rename_part('Vert. mid rail', 'Salvador Vertical Mid Rail')
