import OpenInAppClient from './OpenInAppClient'

export default function DeepLinkRootRedirectPage() {
  const path = '/r'

  return (
    <main className="mx-auto flex min-h-[70vh] w-full max-w-2xl flex-col px-6 py-16">
      <h1 className="text-3xl font-semibold tracking-tight">Open Fluoverse</h1>
      <p className="mt-3 text-base text-black/70">
        Paste or open a deep link like <span className="font-mono text-black">/r/micro</span> to
        open the app. If you don’t have the app installed, continue on the web or install it.
      </p>
      <OpenInAppClient path={path} />
    </main>
  )
}


