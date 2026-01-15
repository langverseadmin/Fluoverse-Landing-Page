import { redirect } from 'next/navigation'

type PageProps = {
  params: { splat?: string[] }
}

export default function DeepLinkRedirectPage({ params }: PageProps) {
  const splat = Array.isArray(params?.splat) ? params.splat : []
  const target = `https://fluoverseapp.netlify.app/${splat.join('/')}`
  redirect(target)
}


