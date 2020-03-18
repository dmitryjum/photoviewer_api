require 'rails_helper'

describe V1::ImagesController do
  before do
    @image1 =  Image.create url: "https://picsum.photos/id/12", dimensions: ["400/200", "300/300"]
    @image2 = Image.create url: "https://picsum.photos/id/44", dimensions: ["250/250"]
    @image3 = Image.create url: "https://picsum.photos/id/48", dimensions: ["100/100"]
    host! 'api.example.com'
  end

   context 'requests the list of all images with no params and gets it in json' do
    before :each do
      get v1_images_path
      @json_body = json_response
    end

    it 'receives success status' do
      expect(response).to be_successful
    end

    it 'receives response as the object with "records", "entries_count", "pages_per_limit", "page" keys' do
      expect(@json_body.keys).to eq ["records", "entries_count", "pages_per_limit", "page"]
    end

    it 'receives response with list of images that are in DB by the "records" key in the response object' do
      image_urls = Image.pluck(:url)
      returned_urls = @json_body['records'].map {|s| s["url"]}
      expect(image_urls).to eq returned_urls
    end
  end

  context "it requests paginated result" do
    it 'requests 2nd page with 2 images per page and receives 1 image from 3' do
      get v1_images_path(per_page: 2, page: 2)
      expect(json_response['records'].length).to be 1
      expect(json_response['records'][0]['url']).to eq("https://picsum.photos/id/48")
    end

    it 'requests 2nd page and forgets to specify the limit and receives 2nd or last page with default of max 9 records per page' do
      get v1_images_path(page: 2)
      expect(json_response['records'].length).to be 3
      expect(json_response['records'].map{|s| s['url']}).to eq ["https://picsum.photos/id/12", "https://picsum.photos/id/44", "https://picsum.photos/id/48"]
    end

    it 'recieves json with "records", "entries_count", "pages_per_limit" and "page" keys' do
      get v1_images_path(per_page: 2, page: 2)
      expect(json_response.keys).to eq(["records", "entries_count", "pages_per_limit", "page"])
    end
  end

  context "it requests all available image dimensions for filter referrence" do
    before :each do
      get dimensions_v1_images_path
    end
    it "receives json with 'dimensions' key and array of strings as a value" do
      expect(json_response['dimensions'].count).to be 4
    end

    it "receives an array of uniq dimensions" do
      expect(json_response['dimensions'].count).to be json_response['dimensions'].uniq.count
    end
  end

  context "it finds images by dimensions in params" do
    it "receives response with correct count images by one specific dimension" do
      get v1_images_path(dimensions: "250/250")
      expect(json_response["records"].count).to be 1
    end

    it "receives response with correct image by one specific dimension" do
      get v1_images_path(dimensions: "250/250")
      expect(json_response["records"].first["url"]).to eq @image2.url
    end

    it "receives response with correct images by 2 specific dimensions passed as an array" do
      get v1_images_path(dimensions: ["250/250", "400/200"])
      expect(json_response["records"].count).to be 2
      expect(json_response["records"].pluck("id").include?(@image1.id)).to be true
      expect(json_response["records"].pluck("id").include?(@image2.id)).to be true
    end

    it "receives paginated response of images by dimensions" do
      get v1_images_path(dimensions: ["250/250", "400/200", "100/100"], per_page: 2, page: 1)
      expect(json_response["records"].count).to be 2
    end
  end

  context "it finds one image by id" do
    it "finds an images successfuly" do
      get v1_image_path(@image1.id)
      expect(json_response["url"]).to eq @image1.url
    end
  end
end