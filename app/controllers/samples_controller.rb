class SamplesController < ApplicationController
  before_filter :load_fields
  def new
    redirect_to new_authorization_path unless authorized?
  end

  def create
    @field_hash = {}
    @fields.each do |f|
      @field_hash["#{f.source}/#{f.name}"] = f
    end

    @fields_to_populate = []
    params[:generate].each do |k,v|
      next unless v=='1'
      @fields_to_populate << @field_hash[k]
    end

    @sources = Hash.new{Array.new}
    @fields_to_populate.each do |f|
      (0..7).each do |d|
        data = @sources[f.source]
        timestamp = Time.now - d.days
        datum = {timestamp: timestamp.iso8601, name: f.name, value: f.value, unit: f.unit}
        data << datum
        @sources[f.source] = data
      end
    end

    File.open('tmp/fart.log', 'a') {|f| f.puts @sources.inspect }

    @sources.each do |k,v|
      api_client.post do |req|
        req.url "/v2/health/source/#{k}/data"
        req.headers['Content-Type'] = 'application/json'
        req.body = v.to_json
      end
    end

    session[:sources] = @sources.keys
    redirect_to sample_path
  end

  def show
    @sources = session[:sources].map do |s|
      [
        s,
        "https://api-mhealth.att.com/v2/health/source/#{s}/data?oauth_token=#{session[:mhealth_token]}"
      ]
    end
  end

  private
  def load_fields
    return unless authorized?
    @fields = MhealthField.get_all api_client
  end
end
