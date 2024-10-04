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
end
