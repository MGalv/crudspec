module Crudspec
  module Generators
    class SpecGenerator < Rails::Generators::Base
      argument :controller_name, :type => :string, :banner => 'controller_name'
      source_root File.expand_path("../templates", __FILE__)
      desc "Create a RSpec spec for a CRUD controller"
      class_option :devise, :desc => "Include steps to authenticate via devise", :type => :string, :banner => "devise_model"

      def generate_spec_file
        underscored = controller_name.underscore
        underscored = underscored + '_controller' unless underscored.match(/_controller$/)
        @class_name = underscored.classify
        @devise = options[:devise] if options[:devise]

        # Really?
        @model_name = @class_name.demodulize.match(/(.+)Controller$/)[1].underscore.singularize
        file_path = "spec/controllers/#{underscored}_spec.rb"

        template('controller_spec.rb', file_path)
      end
    end
  end
end
