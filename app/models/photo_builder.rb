class PhotoBuilder
  def initialize(params)
    @binary = params[:data].read
    @filename = params[:data].original_filename
    @name = params[:name]
    @type = params[:data].content_type
  end

  def build
    Photo.create do |t|
      t.name = @name
      t.data = @binary
      t.filename = @filename
      t.mime_type = @type
    end
  end
end