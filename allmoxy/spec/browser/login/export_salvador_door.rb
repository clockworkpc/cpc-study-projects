require './spec/helpers/browser/pages/sign_in'
require './spec/helpers/browser/pages/home'

pd_url = 'https://panhandledooranddrawer.allmoxy.com/login'
formula_json_file = './spec/helpers/product_parts_formulae.json'
@formulae = JSON.load_file(formula_json_file)

def salvador_formula(part_str, attr_str)
  @formulae['door'][part_str]['salvador'][attr_str]
end

@browser = Watir::Browser.new(:chrome, headless: false)
@s = Browser::Pages::SignIn.new(@browser)
@h = Browser::Pages::Home.new(@browser)

@browser.goto(pd_url)
@s.username_text_field.set('agarber')
@s.password_input.set('ZWiooMyat9kPz8HmTePO')
@s.login_button.click

Watir.default_timeout = 3

def part_string(new_value_str)
  hsh = {
    'Salvador Top Rail' => 'top_rail',
    'Salvador Bottom Rail' => 'bottom_rail',
    'Salvador Right Stile' => 'left_stile',
    'Salvador Left Stile' => 'right_stile',
    'Salvador Horizontal Mid Rail' => 'horizontal_mid_rail',
    'Salvador Vertical Mid Rail' => 'vertical_mid_rail'
  }

  hsh[new_value_str]
end

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

def set_part_export_formula(new_part_id_str, part_str)
  formula_str = salvador_formula(part_str, 'part_export')
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

def set_attribute_formula(new_part_id_str, value_str, part_str)
  attribute_formula_input = attribute_name_input(new_part_id_str, value_str)
  attribute_formula_input.focus
  type_int = attribute_formula_input.attributes[:id].scan(/\[\d\]/).first.scan(/\d+/).first
  id_regex = /(?=.*parts)(?=.*#{new_part_id_str})(?=.*attributes)(?=.*formula)(?=.*\[#{type_int}\])/
  formula_textarea = @browser.textarea(id: id_regex)
  attr_str = value_str.downcase
  formula_textarea.set(salvador_formula(part_str, attr_str))
end

def part_delete(new_part_id_str, new_value_str)
  attribute_name_input = attribute_name_input(new_part_id_str, new_value_str)
  if attribute_name_input.exist?
    trash_i = attribute_name_input.parent.parent.i(class: 'fa fa-trash-o')
    trash_i.click
  end
end

def create_part(value_str, new_value_str)
  part_str = part_string(new_value_str)

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

  set_part_export_formula(new_part_id_str, part_str)
  set_exporter(new_part_id_str, 'Salvador')
  set_precision(new_part_id_str, '.01')

  set_attribute_name(new_part_id_str, 'Length')
  set_attribute_formula(new_part_id_str, 'Length', part_str)

  set_attribute_name(new_part_id_str, 'Width')
  set_attribute_formula(new_part_id_str, 'Width', part_str)

  set_attribute_name(new_part_id_str, 'Qty')
  set_attribute_formula(new_part_id_str, 'Qty', part_str)

  # remove_attribute_cameron_length
  # puts 'Looking to delete Cameron_Length'
  # part_delete(new_part_id_str, 'Cameron_Length')
  # part_delete(new_part_id_str, 'Cameron_Length')
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
