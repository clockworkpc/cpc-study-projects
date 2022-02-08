Watir.default_timeout = 3
SALVADOR_PART_EXPORT_FORMULA_DOOR = ',1, 1, 0, 0,{{this_part.Length}}, {{this_part.Qty}},,1,,,{{this_part.Length}}_{{this_part.Width}}_{{stile_rail.name}}_R_{{order_num}}_{{group_id}}{{line_num}}//{{order_num}}{{group_id}}{{line_num}}3,{{this_part.Width}},{{group_id}}{{line_num}},R'

SALVADOR_PART_ATTRIBUTE_FORMULA_LENGTH = 'round((( width - left_stile_width - right_stile_width + ( stile_rail.Cut_Variable * 2 )+ stile_rail.add_length_for_machining ) * 25.4 ) * 10 ) / 10'

SALVADOR_PART_ATTRIBUTE_FORMULA_WIDTH = 'door_style.Top_rail_material_width > 0 ?
top_rail_width + door_style.Top_rail_material_width :
top_rail_width'

SALVADOR_PART_ATTRIBUTE_FORMULA_QTY = '_panels_wide.Panels_Wide>1?

door_style.Top_rail_material_width>0?

_panels_wide.Panels_Wide

:1

:1'

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

def set_part_export_formula(new_part_id_str, formula_str)
  export_formula_textarea = @browser.textarea(id: /(?=.*#{new_part_id_str})(?=.*cutlist)/)
  export_formula_textarea.set(formula_str)
end

def set_exporter(new_part_id_str, exportor_value_str)
  exporter_dropdown_list = @browser.select(id: /(?=.*#{new_part_id_str})(?=.*exporter)/)
  exporter_dropdown_list.set(exportor_value_str)
end

def set_precision(new_part_id_str, precision_value_str)
  precision_dropdown_list = @browser.select(id: /(?=.*#{new_part_id_str})(?=.*precision)/)
  precision_dropdown_list.set(precision_value_str)
end

def attribute_name_input(new_part_id_str, value_str)
  id_regex = /(?=.*parts)(?=.*#{new_part_id_str})(?=.*attributes)(?=.*name)/
  value_regex = /#{value_str}|#{value_str.downcase}/
  @browser.input(id: id_regex, value: value_regex)
end

def set_attribute_name(new_part_id_str, value_str)
  attribute_name_input = attribute_name_input(new_part_id_str, value_str)
  attribute_name_input.focus
  attribute_name_input.set(value_str)
end

def set_attribute_formula(new_part_id_str, value_str)
  attribute_formula_input = attribute_name_input(new_part_id_str, value_str)
  attribute_formula_input.focus
  type_int = attribute_formula_input.attributes[:id].scan(/\[\d\]/).first.scan(/\d+/).first
  id_regex = /(?=.*parts)(?=.*#{new_part_id_str})(?=.*attributes)(?=.*formula)(?=.*\[#{type_int}\])/
  formula_textarea = @browser.textarea(id: id_regex)
  case value_str
  when 'Length'
    formula_textarea.set(SALVADOR_PART_ATTRIBUTE_FORMULA_LENGTH)
  when 'Width'
    formula_textarea.set(SALVADOR_PART_ATTRIBUTE_FORMULA_WIDTH)
  when 'Qty'
    formula_textarea.set(SALVADOR_PART_ATTRIBUTE_FORMULA_QTY)
  end
end

def part_delete(new_part_id_str, new_value_str)
  attribute_name_input = attribute_name_input(new_part_id_str, new_value_str)
  if attribute_name_input.exist?
    trash_i = attribute_name_input.parent.parent.i(class: 'fa fa-trash-o')
    trash_i.click
  end
end

# To add a "Salvador Top Rail"
# 1. Duplicate the part
# 2. Rename the name field
# 3. Choose Exporter: "Salvador"
# 4. Choose Precision: 1/100 (0.01)
# 5. Replace the Part Export Formula from "Door" OR "Drawer Front"
# 6. Replace the Attribute Formula (Length) from "Door" OR "Drawer Front"
# 7. Set the Attribute Name to "Width"
# 8. Replace the Attribute Formula (Width) from "Door" OR "Drawer Front"
# 9. Remove the Attribute "Cameron_Length"
# 10. Replace the Attribute Formula (Qty) from "Door" OR "Drawer Front"
# 11. Remove the "wood_type_thick_doors" Attribute

def create_part(value_str, new_value_str)
  duplicate_part(value_str)
  new_part_input =  @browser.inputs(value: value_str).last
  new_part_id_str = new_part_input.id.scan(/[a-z]?\d+/).first

  # rename part
  part_input = @browser.inputs(value: value_str).last
  part_input.focus
  part_input.set(new_value_str)

  # unfold part
  @browser.link(onclick: /#{new_part_id_str}/).click

  # set part_formula_name
  regex_formula_name = /(?=.*#{new_part_id_str})(?=.*\[name\])/
  part_formula_name_input = @browser.input(id: regex_formula_name)
  part_formula_name_input.set(new_value_str.parameterize(separator: '_'))

  set_part_export_formula(new_part_id_str, SALVADOR_PART_EXPORT_FORMULA_DOOR)
  set_exporter(new_part_id_str, 'Salvador')
  set_precision(new_part_id_str, '.01')

  set_attribute_name(new_part_id_str, 'Length')
  set_attribute_formula(new_part_id_str, 'Length')

  set_attribute_name(new_part_id_str, 'Width')
  set_attribute_formula(new_part_id_str, 'Width')

  set_attribute_name(new_part_id_str, 'Qty')
  set_attribute_formula(new_part_id_str, 'Qty')

  # remove_attribute_cameron_length
  puts 'Looking to delete Cameron_Length'
  part_delete(new_part_id_str, 'Cameron_Length')
  part_delete(new_part_id_str, 'Cameron_Length')
end

create_part('Top', 'Salvador Top Rail')
create_part('Bottom', 'Salvador Bottom Rail')
create_part('Left', 'Salvador Left Stile')
create_part('Right', 'Salvador Right Stile')
create_part('Horiz. mid rail', 'Salvador Horizontal Mid Rail')
create_part('Vert. mid rail', 'Salvador Vertical Mid Rail')

# def create_salvador_parts
#   duplicate_part('Top')
#   duplicate_part('Bottom')
#   duplicate_part('Left')
#   duplicate_part('Right')
#   duplicate_part('Horiz. mid rail')
#   duplicate_part('Vert. mid rail')

#   rename_part('Top', 'Salvador Top Rail')
#   rename_part('Bottom', 'Salvador Bottom Rail')
#   rename_part('Left', 'Salvador Left Stile')
#   rename_part('Right', 'Salvador Right Stile')
#   rename_part('Horiz. mid rail', 'Salvador Horizontal Mid Rail')
#   rename_part('Vert. mid rail', 'Salvador Vertical Mid Rail')
# end
