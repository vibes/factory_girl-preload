module FactoryGirl
  module Preload
    module Helpers
      def self.extended(base)
        included(base)
      end

      def self.included(base)
        Dir[File.join(RAILS_ROOT, "app/models/**/*.rb")].each do |file|
          require_dependency file
        end

        ActiveRecord::Base.send(:subclasses).each do |model|
          method_name = model.name.underscore.gsub("/", "_").pluralize

          unless method_name.empty?
            class_eval do
              define_method method_name do |name|
                factory(name, model)
              end
            end
          end
        end
      end

      def factory(name, model = nil, &block)
        if block_given?
          factory_set(name, &block)
        else
          factory_get(name, model)
        end
      end

      private
      def factory_get(name, model)
        factory = Preload.factories[model.name][name]
        if factory.blank? && Preload.factories[model.name].has_key?(name)
          factory = Preload.factories[model.name][name] = model.find(Preload.record_ids[model.name][name])
        end
        raise "Couldn't find #{name.inspect} factory for #{model.name.inspect} model" unless factory
        factory
      end

      def factory_set(name, &block)
        record = instance_eval(&block)
        #record = block.call
        Preload.factories[record.class.name] ||= {}
        Preload.factories[record.class.name][name.to_sym] = record

        Preload.record_ids[record.class.name] ||= {}
        Preload.record_ids[record.class.name][name.to_sym] = record.id
      end
    end
  end
end
