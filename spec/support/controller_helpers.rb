module ControllerHelpers
  def login_user(user = create(:user))
    session[:user_id] = user.id
    session[:ctime] = Time.now.tomorrow.utc.to_i
  end

  def create_uploaded_file(file, mime_type)
    ActionDispatch::Http::UploadedFile.new(
      filename: File.basename(file),
      type: mime_type,
      tempfile: File.open(file)
    )
  end
end
