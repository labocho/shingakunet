module Shingakunet
  module Query
    module Paginatable
      def next
        new_params = parameters.dup
        start = (parameters["start"] || 1).to_i
        new_params["start"] = (parameters["start"] || 1).to_i + (parameters["count"] || 10).to_i
        self.class.new(new_params)
      end
    end
  end
end
