import type { Metadata } from 'next'

import EmailConfirmBridgeClient from './EmailConfirmBridgeClient'

export const metadata: Metadata = {
  title: 'Confirming email — Fluverse',
  description: 'Return to the Fluverse app after email verification.',
  robots: { index: false, follow: false },
}

export default function EmailConfirmPage() {
  return (
    <main className="flex min-h-[80vh] w-full flex-col items-center justify-center bg-gradient-to-br from-[#F5F6FF] to-[#E8EAFE] px-6 py-16">
      <EmailConfirmBridgeClient />
    </main>
  )
}
