Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :settings, !types[Types::SettingType] do
    description "Get all settings"
    resolve -> (obj, args, ctx) {
      puts ctx[:current_user]
      Setting.all
    }
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
    resolve -> (obj, args, ctx) {
      Category.all().sort({created: -1})
    }
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
      category = Category.find_by(slug: args['slug'])
      return unless category
      category
    }
  end

  field :blogs, !types[Types::BlogType] do
    description "Get all blog"
    resolve -> (obj, args, ctx) {
      Blog.all().sort({created: -1})
    }
  end

  # Pagination
  field :blogPagination, Types::BlogPaginationType do
    description "Get blog for pagination"
    argument :start, types.Int
    argument :length, types.Int

    resolve -> (obj, args, ctx) {
      count = Blog.count
      OpenStruct.new({
           count: count,
           start: args['start'],
           length: args['length'],
           data: Blog.all().sort({created: -1}).skip(args['start']).limit(args['length']),
           hasNextPage: (args['start'] + args['length']) < count
       })
    }
  end

  # Get Comment pagination by id Blog
  field :commentPaginationByIdBlog, Types::CommentPaginationType do
    description "Get comment pagination by id Blog"
    argument :blog_id, types.ID
    argument :start, types.Int
    argument :length, types.Int

    resolve -> (obj, args, ctx) {
      comment = Comment.where({ blog_id: args['blog_id'] })
      count = comment.count
      OpenStruct.new({
                         count: count,
                         start: args['start'],
                         length: args['length'],
                         data: comment.sort({created: -1}).skip(args['start']).limit(args['length']),
                         hasNextPage: (args['start'] + args['length']) < count
                     })
    }
  end

  field :categoryPagination, Types::CategoryPaginationType do
    description "Get category for pagination"
    argument :start, types.Int
    argument :length, types.Int

    resolve -> (obj, args, ctx) {
      count = Category.count
      OpenStruct.new({
           count: count,
           start: args['start'],
           length: args['length'],
           data: Category.all().sort({created: -1}).skip(args['start']).limit(args['length']),
           hasNextPage: (args['start'] + args['length']) < count
       })
    }
  end

  field :commentPagination, Types::CommentPaginationType do
    description "Get comment for pagination"
    argument :start, types.Int
    argument :length, types.Int

    resolve -> (obj, args, ctx) {
      count = Comment.count
      OpenStruct.new({
           count: count,
           start: args['start'],
           length: args['length'],
           data: Comment.all().sort({created: -1}).skip(args['start']).limit(args['length']),
           hasNextPage: (args['start'] + args['length']) < count
       })
    }
  end

  field :contactPagination, Types::ContactPaginationType do
    description "Get contact for pagination"
    argument :start, types.Int
    argument :length, types.Int

    resolve -> (obj, args, ctx) {
      count = Contact.count
      OpenStruct.new({
           count: count,
           start: args['start'],
           length: args['length'],
           data: Contact.all().sort({created: -1}).skip(args['start']).limit(args['length']),
           hasNextPage: (args['start'] + args['length']) < count
       })
    }
  end

  field :blog, Types::BlogType do
    description "Get blog by id"
    argument :blogId, types.ID, as: :id
    resolve -> (obj, args, ctx) {
      Blog.find(args['id'])
    }
  end

  field :getBlogLatest, !types[Types::BlogType] do
    description "Get blog latest"
    argument :number, types.Int
    resolve -> (obj, args, ctx) {
      Blog.where({}).sort({created: -1}).take(args['number'])
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
    resolve -> (obj, args, ctx) {
      Comment.all().all().sort({created: -1})
    }
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
      images = Image.all
      retult = images.select do |image|
        image.folder_id == args['id']
      end
      retult
    }
  end

  field :contacts, !types[Types::ContactType] do
    description "Get contacts"
    resolve -> (obj, args, ctx) {
      Contact.all().sort({created: -1})
    }
  end

  field :contact, Types::ContactType do
    description "Get contact by id"
    argument :contactId, types.ID, as: :id
    resolve -> (obj, args, ctx) {
      Contact.find(args['id'])
    }
  end

  field :countUnReadContact, !types.Int do
    description "Count Un Read Contact"
    resolve -> (obj, args, ctx) {
      Contact.where(read: false).count
    }
  end

end
