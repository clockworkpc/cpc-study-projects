# frozen_string_literal: true

Rswag::Ui.configure do |c|
  c.swagger_endpoint 'api/swagger_doc.json', 'Docs'
  c.swagger_endpoint 'api/swagger_admin_doc.json', 'Admin Docs Internal'
end
