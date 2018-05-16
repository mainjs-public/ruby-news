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

  field :categorySlug, Types::CategorySlugPaginationType do
    description "Get category by slug"
    argument :slug, !types.String
    argument :start, types.Int
    argument :length, types.Int
    resolve -> (obj, args, ctx) {
      category = Category.find_by(slug: args['slug'])
      return unless category
      blogs = Blog.where(category_id: category.id)
      count = blogs.count
      OpenStruct.new({
           category: category,
           count: count,
           start: args['start'],
           length: args['length'],
           data: blogs.sort({created: -1}).skip(args['start']).limit(args['length']),
           hasNextPage: (args['start'] + args['length']) < count
       })
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
      unless ctx[:current_user]
        count = Blog.count
        OpenStruct.new({
             count: count,
             start: args['start'],
             length: args['length'],
             data: Blog.all().sort({created: -1}).skip(args['start']).limit(args['length']),
             hasNextPage: (args['start'] + args['length']) < count
         })
      else
        if ctx[:current_user].role == 'Contributor'
          blogs = Blog.where({ user_id: ctx[:current_user].id })
          count = blogs.count
          OpenStruct.new({
             count: count,
             start: args['start'],
             length: args['length'],
             data: blogs.sort({created: -1}).skip(args['start']).limit(args['length']),
             hasNextPage: (args['start'] + args['length']) < count
         })
        else
          count = Blog.count
          OpenStruct.new({
               count: count,
               start: args['start'],
               length: args['length'],
               data: Blog.all().sort({created: -1}).skip(args['start']).limit(args['length']),
               hasNextPage: (args['start'] + args['length']) < count
           })
        end
      end
    }
  end

  # Pagination page
  field :pagePagination, Types::PagePaginationType do
    description "Get page for pagination"
    argument :start, types.Int
    argument :length, types.Int

    resolve -> (obj, args, ctx) {
      count = Page.count
      OpenStruct.new({
           count: count,
           start: args['start'],
           length: args['length'],
           data: Page.all().sort({created: -1}).skip(args['start']).limit(args['length']),
           hasNextPage: (args['start'] + args['length']) < count
       })
    }
  end

  # get page by slug
  field :pageSlug, Types::PageType do
    description "Get page by slug"
    argument :slug, !types.String
    resolve -> (obj, args, ctx) {
      Page.find_by(slug: args['slug'])
    }
  end

  # Get list blog by tag
  field :tagPagination, Types::BlogPaginationType do
    description "Get blog by tag"
    argument :tag, !types.String
    argument :start, types.Int
    argument :length, types.Int

    resolve -> (obj, args, ctx) {
      newBlog = Array.new
      Blog.all().sort({created: -1}).each do |blog|
        check = false
        blog.tags.each do |tag|
          if (tag.downcase.gsub(' ', '-') == args['tag'])
            check = true
          end
        end
        if (check)
          newBlog.push(blog)
        end
      end
      count = newBlog.length
      OpenStruct.new({
          count: count,
          start: args['start'],
          length: args['length'],
          data: newBlog,
          hasNextPage: (args['start'] + args['length']) < count
        })
    }
  end

  field :search, Types::BlogPaginationType do
    description "Search blog"

    argument :query, types.String
    argument :start, types.Int
    argument :length, types.Int

    resolve -> (obj, args, ctx) {
      if args[:query]
        Blog.reindex
        blogs = Blog.search args[:query], limit: args['length'], offset: args['start']
        OpenStruct.new({
          count: blogs.size,
          start: args['start'],
          length: args['length'],
          data: blogs,
          hasNextPage: (args['start'] + args['length']) < blogs.size
        })
      else
        nil
      end
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

  field :users, !types[Types::UserType] do
    description "Get users"
    resolve -> (obj, args, ctx) {
      User.all()
    }
  end

end
