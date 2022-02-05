def duplicate_part(value_str)
  part_input = @browser.input(value: value_str)
  part_id_str = part_input.id.scan(/\d+/).first
  part_link = @browser.link(onclick: /#{part_id_str}/, class: nil)
  part_link.focus
  part_link.hover
  part_link.click
end

duplicate_part('Top')
duplicate_part('Bottom')
duplicate_part('Left')
duplicate_part('Right')
duplicate_part('Horiz. mid rail')
duplicate_part('Vert. mid rail')
