Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :settings, !types[Types::SettingType] do
    description "Get all settings"
    resolve -> (obj, args, ctx) {Setting.all}
  end

  field :setting, Types::SettingType do
    description "Get setting by id"
    argument :settingId, types.ID, as: :id
    resolve -> (obj, args, ctx) {
      Setting.find(args['id'])
    }
  end

  field :settingByKey, Types::SettingType do
    description "Get setting by key"
    argument :key, types.String
    resolve -> (obj, args, ctx) {
      Setting.find_by(key: args['key'])
    }
  end

  field :categories, !types[Types::CategoryType] do
    description "Get all categories"
    resolve -> (obj, args, ctx) {Category.all}
  end

  field :category, Types::CategoryType do
    description "Get category by id"
    argument :categoryId, !types.ID, as: :id
    resolve -> (obj, args, ctx) {
      Category.find(args['id'])
    }
  end

  field :categorySlug, Types::CategoryType do
    description "Get category by slug"
    argument :slug, !types.String
    resolve -> (obj, args, ctx) {
      Category.find_by(slug: args['slug'])
    }
  end

  field :blogs, !types[Types::BlogType] do
    description "Get all blog"
    resolve -> (obj, args, ctx) {Blog.all}
  end

  field :blog, Types::BlogType do
    description "Get blog by id"
    argument :blogId, types.ID, as: :id
    resolve -> (obj, args, ctx) {
      Blog.find(args['id'])
    }
  end

  field :blogSlug, Types::BlogType do
    description "Get blog by slug"
    argument :slug, !types.String
    resolve -> (obj, args, ctx) {
      Blog.find_by(slug: args['slug'])
    }
  end

  field :comments, !types[Types::CommentType] do
    description "Get all comment"
    resolve -> (obj, args, ctx) {Comment.all}
  end

  field :comment, Types::CommentType do
    description "Get comment by id"
    argument :commentId, types.ID, as: :id
    resolve -> (obj, args, ctx) {
      Comment.find(args['id'])
    }
  end

  field :folders, !types[Types::FolderType] do
    description "Get folders"
    resolve -> (obj, args, ctx) {
      Folder.all
    }
  end

  field :images, !types[Types::ImageType] do
    description "Get images"
    resolve -> (obj, args, ctx) {
      Image.all
    }
  end

  field :imagesByFolderId, !types[Types::ImageType] do
    description "Get images by folder ID"
    argument :folder_id, types.String, as: :id
    argument :key, types.Int
    resolve -> (obj, args, ctx) {
      puts args['key']
      images = Image.all;
      retult = images.select do |image|
        image.folder_id == args['id']
      end
      retult
    }
  end

end
