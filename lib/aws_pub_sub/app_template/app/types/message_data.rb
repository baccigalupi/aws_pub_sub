module App
  module Types
    MessageData = Struct.new(
      :message,
      :abort
    ) {
      def success?
        !abort
      end
    }
  end
end
