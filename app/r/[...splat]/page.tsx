import OpenInAppClient from '../OpenInAppClient'

type PageProps = {
  params: { splat?: string[] }
}

export default function DeepLinkRedirectPage({ params }: PageProps) {
  const splat = Array.isArray(params?.splat) ? params.splat : []
  const path = `/r/${splat.join('/')}`

  return (
    <main className="mx-auto flex min-h-[70vh] w-full max-w-2xl flex-col px-6 py-16">
      <h1 className="text-3xl font-semibold tracking-tight">Open Fluoverse</h1>
      <p className="mt-3 text-base text-black/70">
        If you have the Fluoverse app installed, this link should open it. Otherwise, continue on
        the web or install the app.
      </p>
      <div className="mt-4 rounded-xl border border-black/10 bg-black/5 p-4 text-sm text-black/70">
        Link: <span className="font-mono text-black">{path}</span>
      </div>
      <OpenInAppClient path={path} />
    </main>
  )
}


