# frozen_string_literal: true

ActiveModelSerializers.config.default_includes = '**'
ActiveModel::Serializer.config.adapter = :attributes
