# require 'rails_helper'

# class TestImageUploader
#   mount_uploader :image, ImageUploader
# end

# describe ImageUploader do
#   include FakeFS::SpecHelpers

#   context 'for non-production environment' do
#     it 'should upload video clip to dev-bucket on s3' do
#       FakeFS.activate!
#       FakeFS::File.should_receive(:chmod) #this is needed or you will get an exception
#       File.open('test_file', 'w') do |f|
#         f.puts('foo') # this is required or uploader_test.file.url will be nil
#       end
#       uploader_test = Image.new
#       uploader_test.file = File.open('test_file')
#       uploader_test.save!
#       uploader_test.file.url.should match /.*\/dev-bucket.*/ #test to make sure that it is not production-bucket
#       FakeFS.deactivate!
#     end
#   end
# end
