module ApplicationHelper
  def default_meta_tags
    {
      site: 'サイゼリヤ攻略サイト',
      title: 'サイゼリヤ攻略サイト',
      reverse: true,
      charset: 'utf-8',
      description: 'サイゼリヤをさらに楽しむためのコミュニティサイトです。',
      keywords: 'サイゼリヤ,アレンジ,ファミレス',
      canonical: request.original_url,
      separator: '|',
      og:{
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@',
        image: image_url('ogp.png')
      }
    }
  end

  def flash_message(type)
    case type.to_sym
    when :success then "bg-blue-100 border border-blue-500 text-blue-700 px-4 py-3 rounded-xl text-center"
    when :alert, :danger then "bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-xl text-center"
    else "bg-yellow-100 border border-yellow-500 text-yellow-700 px-4 py-3 rounded-xl text-center"
    end
  end
end
