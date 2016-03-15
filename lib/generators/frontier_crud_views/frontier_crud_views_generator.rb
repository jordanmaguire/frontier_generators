require_relative "../../frontier"

class FrontierCrudViewsGenerator < Frontier::Generator
  source_root File.expand_path('../templates', __FILE__)

  def scaffold
    unless model_configuration.skip_ui?
      [
        ["index.html.haml", model_configuration.show_index?],
        ["_form.html.haml", model_configuration.show_create? || model_configuration.show_update?],
        ["new.html.haml", model_configuration.show_create?],
        ["edit.html.haml", model_configuration.show_update?]
      ].each do |template_filename, should_generate|
        if should_generate
          template template_filename, File.join(Frontier::Views::ViewsFolderPath.new(model_configuration).to_s, template_filename)
        end
      end

      plural = model_configuration.model_name.pluralize

      generate_feature_path("index_spec.rb", "admin_index_#{plural}_spec.rb") if model_configuration.show_index?
      generate_feature_path("delete_spec.rb", "admin_delete_#{plural}_spec.rb") if model_configuration.show_delete?
      generate_feature_path("create_spec.rb", "admin_create_#{plural}_spec.rb") if model_configuration.show_create?
      generate_feature_path("update_spec.rb", "admin_update_#{plural}_spec.rb") if model_configuration.show_update?
    end
  end

private

  def instance_actions
    @instance_actions ||= Frontier::Views::Index::InstanceActions.new(model_configuration)
  end

  def generate_feature_path(template_name, feature_name)
    feature_path = File.join(Frontier::Views::FeatureSpecPath.new(model_configuration).to_s, feature_name)
    template(template_name, feature_path)
  end

end
