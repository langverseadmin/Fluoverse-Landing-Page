import OpenInAppClient from '../OpenInAppClient'

type PageProps = {
  params: { splat?: string[] }
}

export default function DeepLinkRedirectPage({ params }: PageProps) {
  const splat = Array.isArray(params?.splat) ? params.splat : []
  const path = `/r/${splat.join('/')}`

  return (
    <main className="mx-auto flex min-h-[70vh] w-full max-w-2xl items-center justify-center px-6 py-16">
      <OpenInAppClient path={path} />
    </main>
  )
}


