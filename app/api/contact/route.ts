import { NextRequest, NextResponse } from "next/server";

type ContactPayload = {
  name?: string;
  email?: string;
  subject?: string;
  message?: string;
  organisation?: string;
  partnerType?: string;
  location?: string;
  source?: string;
};

const API_BASE_URL = (
  process.env.NEXT_PUBLIC_API_BASE_URL ||
  process.env.API_BASE_URL ||
  "https://fluoverse.onrender.com"
).replace(/\/$/, "");

function isValidEmail(email: string) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function buildMessage(body: {
  message: string;
  organisation: string;
  partnerType: string;
  location: string;
  source: string;
}) {
  // The contact email is HTML and collapses \n to spaces, so use
  // separators that stay readable even when line breaks are stripped.
  const meta: string[] = [];

  if (body.source === "become-a-partner") {
    meta.push("Source: Become a Partner form");
  }
  if (body.organisation) meta.push(`Organisation: ${body.organisation}`);
  if (body.partnerType) meta.push(`Partner type: ${body.partnerType}`);
  if (body.location) meta.push(`City & country: ${body.location}`);

  if (meta.length === 0) {
    return body.message;
  }

  return `${meta.join("  |  ")}\n\nMessage: ${body.message}`;
}

export async function POST(request: NextRequest) {
  try {
    const body = (await request.json()) as ContactPayload;

    const name = (body.name || "").trim();
    const email = (body.email || "").trim();
    const subject = (body.subject || "").trim();
    const message = (body.message || "").trim();
    const organisation = (body.organisation || "").trim();
    const partnerType = (body.partnerType || "").trim();
    const location = (body.location || "").trim();
    const source = (body.source || "contact").trim();

    if (!name || !email || !message) {
      return NextResponse.json(
        { success: false, error: "Please fill in all required fields." },
        { status: 400 },
      );
    }

    if (!isValidEmail(email)) {
      return NextResponse.json(
        { success: false, error: "Please enter a valid email address." },
        { status: 400 },
      );
    }

    // Same contract as https://fluoverse.onrender.com/contact
    const upstreamPayload = {
      name,
      email,
      subject: subject || (source === "become-a-partner" ? "Partnership Inquiry" : "Website inquiry"),
      message: buildMessage({
        message,
        organisation,
        partnerType,
        location,
        source,
      }),
    };

    const upstreamRes = await fetch(`${API_BASE_URL}/contact`, {
      method: "POST",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
      },
      body: JSON.stringify(upstreamPayload),
      cache: "no-store",
    });

    if (!upstreamRes.ok) {
      let upstreamError = "Sorry, something went wrong. Please try again later.";
      try {
        const upstreamJson = (await upstreamRes.json()) as { error?: string; message?: string };
        if (upstreamJson.error || upstreamJson.message) {
          upstreamError = upstreamJson.error || upstreamJson.message || upstreamError;
        }
      } catch {
        // keep default error
      }

      return NextResponse.json(
        {
          success: false,
          error: upstreamError,
        },
        { status: 502 },
      );
    }

    return NextResponse.json({
      success: true,
      message: "Thank you! Your message has been sent successfully.",
    });
  } catch {
    return NextResponse.json(
      { success: false, error: "Something went wrong. Please try again." },
      { status: 500 },
    );
  }
}
