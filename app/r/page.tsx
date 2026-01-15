import OpenInAppClient from './OpenInAppClient'

export default function DeepLinkRootRedirectPage() {
  const path = '/r'

  return (
    <main className="mx-auto flex min-h-[70vh] w-full max-w-2xl items-center justify-center px-6 py-16">
      <OpenInAppClient path={path} />
    </main>
  )
}


