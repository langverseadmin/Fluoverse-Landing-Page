import type { CityGuideData, ExchangeListing, SpainHubData } from "./types";
import { MEETUP_LISTING_IMAGES as IMG } from "./listing-images";
const GUIDE_BASE = "/guides/making-friends-abroad/spain";
export const spainHubData: SpainHubData = {
  title: "How to Make Friends in Spain & Feel at Home (2026)",
  description:
    "Stop feeling alone in Spain. Start feeling at home. City guides for Madrid and Valencia, language exchanges, social apps, and a plan to turn lonely weekends into real friendships.",
  keywords: [
    "how to make friends in Spain",
    "feel at home in Spain",
    "lonely in Spain",
    "new in Spain no friends",
    "moved to Spain alone",
    "make real friends Spain",
    "expat friends Spain",
    "social life Spain",
    "how to meet people in Spain",
  ],
  heroTitle: "How to make friends in Spain",
  heroAccent: "after moving abroad",
  heroEyebrow: "Spain · 2026 guide",
  empathyIntro:
    "How to make friends in Spain when weekends feel empty: most people who move abroad hit a lonely stretch before friendships click. This guide gives you a city-by-city plan, language exchanges, social apps, and what to say in Spanish when you show up.",
  struggleIntro:
    "The same walls came up again and again, and almost none of them are your fault.",
  struggleInterviewIntro: "We interviewed 10 people across Spain who recently moved",
  struggleQuotes: [
    {
      quote:
        "Locals have had the same friends since primary school. There's no obvious door to knock on.",
      tag: "The closed-circle wall · 9 mentions",
    },
    {
      quote:
        "They're warm and curious on the surface, but it never turns into an actual invitation.",
      tag: "Superficial friendliness · 4 mentions",
    },
    {
      quote:
        "Working from home, I could go days without a single real conversation.",
      tag: "Remote-work isolation · 4 mentions",
    },
    {
      quote:
        "I meet plenty of people. It just never converts, like a funnel where no one follows through.",
      tag: "Follow-up rarely sticks · 2 mentions",
    },
  ],
  successVision:
    "Picture month three: a Tuesday language exchange where people know your name, a padel group that texts you to play, a barrio WhatsApp that pings with last-minute plans. Not a huge crowd, a handful of genuine friendships. That is what living fully in your new community feels like, and it is closer than it feels right now.",
  whatWorks: [
    "Small gatherings of 5-8 people beat big 50-person mixers for real connection.",
    "Recurring weekly activities, same place, same faces, build trust far faster than one-off events.",
    "Following up first: suggesting the next plan is what turns an acquaintance into a friend.",
    "Activities built around a shared interest work better than events labelled 'meet new people'.",
    "People who moved abroad who cracked it gave it 2-3 months of consistent invites before it clicked.",
  ],
  guideEmpathy:
    "Fluoverse was built by founders who relocated abroad and lived this exact loneliness. We help you go from just landed to feeling at home: find activities with people who share your interests, stay in touch between meetups until friendships stick, and learn the language and culture you need to communicate and integrate fully.",
  monthTimeline: [
    {
      period: "Month 1",
      feeling: "Excited but disconnected, everything is new and exhausting.",
      action:
        "Pick one recurring event (language exchange or hobby) and go twice. Do not chase ten different meetups.",
    },
    {
      period: "Month 2",
      feeling: "Still lonely on quiet days, but you recognize a few faces.",
      action:
        'Repeat the same venue. Ask one person: "¿Quedamos otro día?" Friendships in Spain grow through repetition.',
    },
    {
      period: "Month 3",
      feeling:
        "A small circle starts forming, or you know where you belong on Tuesdays.",
      action:
        "Add a second social layer (padel, climbing, or a WhatsApp group for your barrio). Depth beats breadth.",
    },
  ],
  cityCards: [
    {
      city: "Madrid",
      href: `${GUIDE_BASE}/madrid`,
      blurb:
        "Weekly social calendar, language exchanges, Telegram groups, and a first-30-days plan for shy newcomers in Malasaña, Lavapiés, and Chamberí.",
    },
    {
      city: "Valencia",
      href: `${GUIDE_BASE}/valencia`,
      blurb:
        "Ruzafa and El Carmen meetups, beach-side language exchanges, newcomer groups, and low-pressure venues for your first month.",
    },
  ],
  faqs: [
    {
      question: "How to make friends in Spain?",
      answer:
        "Pick one recurring event like a language exchange or hobby group and go twice before trying something new. Madrid and Valencia have the busiest newcomer scenes. Use our city guides for weekly calendars and social apps.",
    },
    {
      question: "Is it normal to feel lonely after moving to Spain?",
      answer:
        "Yes. Relocation shock is common, especially in month one when work is busy, Spanish feels slow, and plans happen last-minute on WhatsApp. Most people who move abroad need 2 to 3 months of showing up to the same places before friendships feel real.",
    },
    {
      question:
        "How long does it take to make friends after moving abroad in Spain?",
      answer:
        "Many people who moved abroad report their first real friends around weeks 6 to 12, if they attend one or two recurring events weekly. One-off networking nights rarely lead to lasting friendships; repetition at language exchanges, sports, or coworking social hours works better.",
    },
    {
      question: "Do I need fluent Spanish to make friends in Spain?",
      answer:
        "No, but basic Spanish helps you move from polite small talk to real plans. Language exchanges are designed for mixed levels. Practice key phrases before you go so you show up less anxious.",
    },
    {
      question: "What is the fastest way to meet people in Spain?",
      answer:
        "Join a recurring language exchange, a beginner padel group, or a neighborhood Telegram/WhatsApp group. Spain is WhatsApp-first, people confirm plans hours before, not days ahead.",
    },
  ],
  breadcrumbs: [
    { name: "Home", href: "/" },
    { name: "Guides", href: GUIDE_BASE },
    { name: "Spain", href: GUIDE_BASE },
  ],
};
const madridBreadcrumbs = [
  { name: "Home", href: "/" },
  { name: "Guides", href: GUIDE_BASE },
  { name: "Spain", href: GUIDE_BASE },
  { name: "Madrid", href: `${GUIDE_BASE}/madrid` },
];
export const madridGuideData: CityGuideData = {
  slug: "madrid",
  city: "Madrid",
  citySpanish: "Madrid",
  path: `${GUIDE_BASE}/madrid`,
  title: "How to Make Friends in Madrid & Feel at Home (2026)",
  description:
    "Stop feeling alone in Spain. Start feeling at home. Weekly language exchanges, meetups, social apps, and real Spanish for social situations in Madrid.",
  keywords: [
    "how to make friends in Madrid",
    "feel at home Madrid",
    "lonely in Madrid",
    "moved to Madrid alone",
    "new in Madrid no friends",
    "making friends Madrid expat",
    "language exchange Madrid",
    "how to meet people in Madrid",
  ],
  heroTitle: "How to make friends in Madrid",
  heroAccent: "after moving abroad",
  heroEyebrow: "Madrid · 2026 guide",
  empathyOpener:
    "How to make friends in Madrid when your evenings feel too quiet: loneliness in month one is normal. Friendships here grow through repeat attendance at the same language exchange, bar, or padel court, not one-off networking events.",
  struggleIntro:
    "The same barriers came up over and over. Recognising them is the first step past them.",
  struggleInterviewIntro: "We interviewed 10 people in Madrid",
  struggleQuotes: [
    {
      quote:
        "Madrileños have had their group since school. Breaking in feels impossible some days.",
      tag: "Closed local circles · 9 mentions",
    },
    {
      quote:
        "At a 50-person meetup I barely spoke to anyone. Too big to actually connect.",
      tag: "Huge events don't work · 6 mentions",
    },
    {
      quote:
        "My Spanish would freeze the second the conversation sped up, so I'd just go quiet.",
      tag: "The language freeze · 8 mentions",
    },
    {
      quote: "People say 'we should grab a cana!' and then it never happens.",
      tag: "Invitations that vanish · 4 mentions",
    },
  ],
  successVision:
    "Imagine Madrid in a few months: a Thursday language exchange in Lavapies where the regulars wave you over, a padel partner who pings you on Saturdays, a WhatsApp group plotting late-night planes. A small circle that feels like home. That is what we are building toward, one repeated, low-pressure step at a time.",
  whatWorks: [
    "Pick one small recurring language exchange and return weekly, familiar faces beat new crowds.",
    "Lead with a shared interest (padel, climbing, a class), not 'let's network'.",
    "Get one WhatsApp number per event and follow up first within 48 hours.",
    "Keep groups small, 5-8 people is where real conversations happen.",
    "Give it 2-3 months of showing up before judging whether Madrid is 'cold'.",
  ],
  guideEmpathy:
    "We moved abroad too. We know what it feels like to walk into a Spanish bar alone and still feel like a tourist months later. Fluoverse helps you go from just landed to feeling at home: discover interest-based activities, keep conversations going after events, and build the language and cultural skills to communicate and integrate fully.",
  quickAnswerSteps: [
    "Pick one recurring language exchange in Lavapiés or Malasaña and go twice in your first two weeks.",
    "Join a Madrid international Meetup or InterNations event to find people who also arrived recently.",
    "Add a low-pressure hobby: beginner padel or a climbing gym session, sport is Spain's #1 social shortcut.",
    "Save 3 to 5 Spanish phrases for introductions and follow-ups (see scripts below).",
    'Repeat the same venue weekly; ask one person "¿Quedamos otro día?" before you leave.',
  ],
  first30Days: [
    {
      week: "Week 1",
      title: "One language exchange, no pressure",
      actions: [
        "Book Thursday language exchange at Language Exchange Madrid (LEM) at La Fontana de Oro (Centro).",
        "Goal: say hello to 3 people, not find a best friend.",
        'Practice: "Hola, soy [name], llevo poco tiempo en Madrid."',
      ],
    },
    {
      week: "Week 2",
      title: "Add a hobby layer",
      actions: [
        "Try a beginner padel session or bouldering at Sharma Climbing (Madrid Río).",
        "Sport removes awkward small-talk pressure, you talk between points.",
        "Say yes if someone suggests coffee after; plans are often same-day in Madrid.",
      ],
    },
    {
      week: "Week 3",
      title: "Repeat, don't restart",
      actions: [
        "Return to the same language exchange from Week 1, familiar faces matter.",
        'Message one person from Week 2: "¿Quedamos esta semana?"',
        "Join a neighborhood-focused Meetup (Malasaña, Chamberí, or Retiro).",
      ],
    },
    {
      week: "Week 4",
      title: "Build a rhythm",
      actions: [
        "Lock in one weekly social anchor (language exchange OR padel OR coworking social hour).",
        "Explore one WhatsApp/Telegram newcomer group for your barrio, lurk first, then reply to one post.",
        "Use Fluoverse between events to practice phrases, learn local culture, and stay ready for the next invite.",
      ],
    },
  ],
  socialCalendar: [],
  socialLinks: [
    {
      label: "Language Exchange Madrid (LEM)",
      description:
        "Madrid's largest weekly language exchange at La Fontana de Oro, 600+ people/month, newcomer-friendly.",
      url: "https://www.meetup.com/intercambio-de-idioma-en-madrid/",
      channel: "meetup",
      neighborhood: "Centro / Sol",
      imageUrl: IMG.madridLem.url,
      imageAlt: IMG.madridLem.alt,
      source: IMG.madridLem.source,
    },
    {
      label: "Spanish & International Friends in Madrid",
      description:
        "Oldest active Madrid language exchange group, Thursdays & Sundays at Beer Station.",
      url: "https://www.meetup.com/language-exchange-madrid/",
      channel: "meetup",
      neighborhood: "Callao",
      imageUrl: IMG.madridBeerStation.url,
      imageAlt: IMG.madridBeerStation.alt,
      source: IMG.madridBeerStation.source,
    },
    {
      label: "InterNations Madrid",
      description:
        "Professional international network with monthly official events.",
      url: "https://www.internations.org/madrid-expats",
      channel: "event",
      neighborhood: "Centro",
      source: "InterNations",
    },
    {
      label: "WhatsApp groups (via event hosts)",
      description:
        "LEM and Beer Station hosts share WhatsApp community links at events, ask the organizer on your first night.",
      url: "https://www.whatsapp.com/",
      channel: "whatsapp",
      neighborhood: "City-wide",
      source: "WhatsApp",
    },
  ],
  shyVenues: [
    {
      name: "Language Exchange Madrid (LEM) , La Fontana de Oro",
      why: "Structured rotations at Madrid's most established language exchange, organizers introduce newcomers.",
      neighborhood: "Centro / Sol",
      tip: "Arrive by 20:30; dress smart-casual (no tracksuits).",
    },
    {
      name: "Beer Station (Thursday/Sunday)",
      why: "Long-running group with reduced drink prices for attendees, very international crowd.",
      neighborhood: "Callao",
      tip: "Newbies welcome every week; RSVP on Meetup but most people don't, just show up.",
    },
    {
      name: "Sharma Climbing (Madrid Río)",
      why: "Bouldering is solo-friendly but social at the mats between climbs.",
      neighborhood: "Arganzuela",
      tip: 'Ask "¿Puedo hacer este bloque contigo?" to break the ice.',
    },
  ],
  appReviews: [
    {
      appId: "fluoverse",
      name: "Fluoverse",
      pros: "More than a language app. Fluoverse helps you move from just landed to feeling at home: discover activities with people who share your interests, follow up between meetups, and learn language and culture for real conversations with locals.",
      cons: "That you haven't signed up YET!!",
      bestFor: "Building friendships that last beyond one good night out.",
      highlight: true,
    },
    {
      appId: "meetup",
      name: "Meetup",
      pros: "Best for finding recurring language exchanges and international events in Madrid.",
      cons: "Quality varies; read recent reviews before committing.",
      bestFor: "Your first two weeks, book 1 to 2 events only.",
    },
    {
      appId: "whatsapp",
      name: "WhatsApp",
      pros: "Real plans happen here, LEM and Beer Station hosts share community groups after events.",
      cons: "You usually need to attend an event first to get invited.",
      bestFor: "Week 3+ once you have one in-person contact.",
    },
    {
      appId: "playtomic",
      name: "Playtomic",
      pros: "Book padel matches with strangers at your level, very social in Spain.",
      cons: "Requires basic equipment knowledge or a willingness to learn.",
      bestFor: "Week 2 hobby layer.",
    },
    {
      appId: "facebook_groups",
      name: "Facebook Groups",
      pros: "Massive local communities for every interest; easy to find city-specific newcomer groups.",
      cons: "Notifications can get noisy; quality varies by group.",
      bestFor: "Finding niche hobby and neighbourhood groups before your first week.",
    },
  ],
  conversationScripts: [
    {
      situation: "Introducing yourself at a language exchange",
      spanish:
        "Hola, soy [nombre]. Llevo [X] semanas en Madrid y estoy aprendiendo español.",
      english:
        "Hi, I'm [name]. I've been in Madrid for [X] weeks and I'm learning Spanish.",
    },
    {
      situation: "Asking to meet again",
      spanish:
        "Me ha gustado mucho hablar contigo. ¿Quedamos otro día para un café?",
      english:
        "I really enjoyed talking with you. Want to meet another day for coffee?",
    },
    {
      situation: "When you don't understand",
      spanish: "Perdona, ¿puedes repetir más despacio? Estoy aprendiendo.",
      english: "Sorry, can you repeat more slowly? I'm still learning.",
    },
    {
      situation: "Joining a group conversation",
      spanish: "¿Os importa si me uno? Acabo de llegar a Madrid.",
      english: "Do you mind if I join? I just arrived in Madrid.",
    },
    {
      situation: "Confirming WhatsApp plans",
      spanish:
        "Perfecto, nos vemos allí. Te escribo por WhatsApp si me retraso.",
      english: "Perfect, see you there. I'll WhatsApp you if I'm running late.",
    },
  ],
  localNuances: [
    "Plans are often confirmed hours before on WhatsApp, not a week ahead by email.",
    "Friendships grow by seeing the same people weekly at the same bar or language exchange.",
    "Spaniards may seem reserved at first; persistence (without pressure) is normal.",
    "Padel is the default social sport, easier entry than football for newcomers.",
    'Dinner starts late (21:00+); "quedar" for drinks often means 20:00 to 20:30.',
  ],
  languageBridge: {
    heading: "Stop feeling alone in Spain. Start feeling at home",
    body: "Friendships need more than one good night out. Fluoverse helps you find shared-interest activities, practice real Spanish situations (ordering coffee, small talk, asking to meet again), learn cultural context, and stay in conversation between events so integration feels natural, not forced.",
  },
  faqs: [
    {
      question: "How to make friends in Madrid?",
      answer:
        "Pick one recurring language exchange in Lavapiés or Malasaña and go twice in your first two weeks. Add a hobby layer like padel, follow up on WhatsApp within 48 hours, and repeat the same venue weekly.",
    },
    {
      question: "Is it normal to feel lonely after moving to Madrid?",
      answer:
        "Yes. Madrid is huge and social life runs on existing circles. Month one is often the hardest. Pick one recurring event and go twice, that beats trying ten different apps.",
    },
    {
      question:
        "How long until you make friends after moving abroad in Madrid?",
      answer:
        "Many people who moved abroad see their first real friendships around weeks 6 to 12 if they repeat the same language exchange or hobby weekly. One-off events rarely stick.",
    },
    {
      question: "Where is the best language exchange in Madrid for beginners?",
      answer:
        "Big Bang Language Exchange (Tuesdays, Centro) and smaller Lavapiés café language exchanges (Thursdays) are newcomer-friendly. See our full language exchange guide for more options.",
    },
    {
      question: "Do Madrileños use WhatsApp for friend plans?",
      answer:
        "Almost always. Get someone's WhatsApp at an event, then confirm same-day. Email or Instagram DMs are secondary for social plans.",
    },
  ],
  breadcrumbs: madridBreadcrumbs,
  relatedLinks: [
    {
      label: "Language exchange Madrid",
      href: "/guides/intercambio-idiomas-madrid",
      description: "Deep dive on the best language exchanges in Madrid.",
    },
    {
      label: "Social apps if you moved abroad in Spain",
      href: "/guides/social-apps-expats-spain-2026",
      description:
        "WhatsApp, Meetup, Facebook Groups, and what actually works in 2026.",
    },
    {
      label: "Spain social guide",
      href: GUIDE_BASE,
      description: "Month-by-month plan for all of Spain.",
    },
  ],
};
const valenciaBreadcrumbs = [
  { name: "Home", href: "/" },
  { name: "Guides", href: GUIDE_BASE },
  { name: "Spain", href: GUIDE_BASE },
  { name: "Valencia", href: `${GUIDE_BASE}/valencia` },
];
export const valenciaGuideData: CityGuideData = {
  slug: "valencia",
  city: "Valencia",
  citySpanish: "Valencia",
  path: `${GUIDE_BASE}/valencia`,
  title: "How to Make Friends in Valencia & Feel at Home (2026)",
  description:
    "Stop feeling alone in Spain. Start feeling at home. Language exchanges in Ruzafa, beach meetups, social apps, and a first-month plan to build a real social circle in Valencia.",
  keywords: [
    "how to make friends in Valencia",
    "feel at home Valencia",
    "lonely in Valencia",
    "moved to Valencia alone",
    "new in Valencia no friends",
    "making friends Valencia expat",
    "language exchange Valencia",
    "how to meet people in Valencia",
  ],
  heroTitle: "How to make friends in Valencia",
  heroAccent: "after moving abroad",
  heroEyebrow: "Valencia · 2026 guide",
  empathyOpener:
    "How to make friends in Valencia when quiet evenings in Ruzafa or Benimaclet still hit hard: the city is smaller than Madrid, so friendships form faster when you repeat the same beach run, language exchange, or padel group.",
  struggleIntro:
    "The city is friendlier than most, but the same hurdles still slow newcomers down.",
  struggleInterviewIntro: "We interviewed 10 people in Valencia",
  struggleQuotes: [
    {
      quote:
        "Everyone's lovely, but their friends are already locked in from years ago.",
      tag: "Closed local circles · 9 mentions",
    },
    {
      quote:
        "Language exchanges were full of other foreigners, I barely met any Valencians.",
      tag: "Hard to reach locals · 6 mentions",
    },
    {
      quote: "I'd meet someone great and then chicken out of messaging first.",
      tag: "Fear of following up · 3 mentions",
    },
    {
      quote:
        "The international crowd is always coming and going. Hard to build something lasting.",
      tag: "Transient community · 5 mentions",
    },
  ],
  successVision:
    "Picture a few months from now: a Ruzafa language exchange that feels like your Tuesday ritual, a beach-volleyball crew at Malvarrosa, a Sunday run group along the Turia. Valencia rewards consistency, show up, follow up, and a real circle forms faster than you'd expect.",
  whatWorks: [
    "Repeat one Ruzafa or El Carmen language exchange weekly instead of bouncing between events.",
    "Use Valencia's outdoor culture, beach and park sport is the easiest social entry.",
    "Message first within a couple of days; small effort, big payoff here.",
    "Favour small gatherings; Valencia's scene is intimate by nature.",
    "Stay consistent through the quiet August lull, routines rebuild fast in September.",
  ],
  guideEmpathy:
    "Fluoverse was built by founders who relocated abroad and know the quiet-flat loneliness of the first months. We help you go from just landed to feeling at home: find beach runs and Ruzafa meetups with people who share your interests, keep the conversation going between events, and learn language and culture so Valencia starts to feel like yours.",
  quickAnswerSteps: [
    "Start with a Ruzafa or El Carmen language exchange, Valencia's international scene clusters there.",
    "Join Valencia newcomers Meetup for newcomers who arrived in the last year.",
    "Try a Saturday morning social run or beach volleyball group at Malvarrosa.",
    "Learn 3 to 5 Spanish phrases for introductions (scripts below).",
    "Return to the same event weekly; Valencia rewards consistency over volume.",
  ],
  first30Days: [
    {
      week: "Week 1",
      title: "Ruzafa language exchange",
      actions: [
        "Attend a mid-week language exchange in Ruzafa or El Carmen.",
        "Goal: 3 conversations, 60 minutes total.",
        'Practice: "Acabo de mudarme a Valencia."',
      ],
    },
    {
      week: "Week 2",
      title: "Beach or sport",
      actions: [
        "Join a beach volleyball or padel session via Meetup or Playtomic.",
        "Valencia's outdoor culture makes sport the easiest social entry.",
      ],
    },
    {
      week: "Week 3",
      title: "Repeat your anchor",
      actions: [
        "Go back to Week 1's language exchange, names and faces matter.",
        'Invite someone: "¿Tomamos algo en Ruzafa este finde?"',
      ],
    },
    {
      week: "Week 4",
      title: "Neighborhood group",
      actions: [
        "Find a Benimaclet or Cabanyal Telegram/WhatsApp group via event hosts.",
        "Lock one weekly rhythm: language exchange OR sport OR coworking social.",
      ],
    },
  ],
  socialCalendar: [
    {
      day: "Monday",
      title: "Monday Language Exchange @ Big Ben",
      time: "20:30",
      venue: "Big Ben, Plaza Honduras 36",
      neighborhood: "Benimaclet",
      url: "https://www.meetup.com/valencia-language-exchange-tandem/",
      channel: "meetup",
      imageUrl: IMG.valenciaVle.url,
      imageAlt: IMG.valenciaVle.alt,
      source: IMG.valenciaVle.source,
    },
    {
      day: "Wednesday",
      title: "Language Exchange Bendita Birra",
      time: "20:00",
      venue: "Bendita Birra, Blasco Ibañez",
      neighborhood: "Blasco Ibañez",
      url: "https://www.meetup.com/language-exchange-bendita-birra/",
      channel: "meetup",
      imageUrl: IMG.valenciaBenditaBirra.url,
      imageAlt: IMG.valenciaBenditaBirra.alt,
      source: IMG.valenciaBenditaBirra.source,
    },
    {
      day: "Thursday",
      title: "Thursday Language Exchange + Quiz (VLE)",
      time: "20:30",
      venue: "Big Ben, Plaza Honduras 36",
      neighborhood: "Benimaclet",
      url: "https://www.meetup.com/valencia-language-exchange-tandem/",
      channel: "meetup",
      imageUrl: IMG.valenciaVle.url,
      imageAlt:
        "Valencia Language Exchange Thursday quiz night , Meetup listing photo",
      source: IMG.valenciaVle.source,
    },
  ],
  socialLinks: [
    {
      label: "Valencia Language Exchange (VLE)",
      description:
        "Valencia's largest language exchange community, Monday & Thursday at Big Ben, events since 2007.",
      url: "https://www.meetup.com/valencia-language-exchange-tandem/",
      channel: "meetup",
      neighborhood: "Benimaclet",
      imageUrl: IMG.valenciaVle.url,
      imageAlt: IMG.valenciaVle.alt,
      source: IMG.valenciaVle.source,
    },
    {
      label: "Language Exchange Bendita Birra",
      description:
        "Wednesday multilingual exchange with board games, ask for Laura or Angie.",
      url: "https://www.meetup.com/language-exchange-bendita-birra/",
      channel: "meetup",
      neighborhood: "Blasco Ibañez",
      imageUrl: IMG.valenciaBenditaBirra.url,
      imageAlt: IMG.valenciaBenditaBirra.alt,
      source: IMG.valenciaBenditaBirra.source,
    },
    {
      label: "InterNations Valencia",
      description: "Monthly official events for international professionals.",
      url: "https://www.internations.org/valencia-expats",
      channel: "event",
      neighborhood: "Centro",
      source: "InterNations",
    },
  ],
  shyVenues: [
    {
      name: "Valencia Language Exchange , Monday @ Big Ben",
      why: "Smaller Monday crowd (60 to 80 people) with games, less overwhelming than Thursday.",
      neighborhood: "Benimaclet",
      tip: "Ask coordinators Michael or Moa to introduce you.",
    },
    {
      name: "Bendita Birra (Wednesday)",
      why: "Board games break the ice; multilingual and very relaxed.",
      neighborhood: "Blasco Ibañez",
      tip: "Grab a drink and ask for Laura or Angie when you arrive.",
    },
    {
      name: "Turia running groups",
      why: "Side-by-side running reduces eye-contact pressure.",
      neighborhood: "Turia",
      tip: "Sunday mornings are the most casual.",
    },
  ],
  appReviews: [
    {
      appId: "fluoverse",
      name: "Fluoverse",
      pros: "More than a language app. Fluoverse helps you move from just landed to feeling at home in Valencia: shared-interest activities, follow-ups between meetups, and language and culture for beach plans, Ruzafa nights, and real local friendships.",
      cons: "That you haven't signed up YET!!",
      bestFor: "Turning a great first night in Ruzafa into people you see every week.",
      highlight: true,
    },
    {
      appId: "meetup",
      name: "Meetup",
      pros: "Strong Valencia moved abroad and language exchange scene, VLE and Bendita Birra run weekly.",
      cons: "Summer attendance dips, check event comments.",
      bestFor: "Week 1 to 2 discovery.",
    },
    {
      appId: "whatsapp",
      name: "WhatsApp",
      pros: "Beach plans and last-minute quedadas happen here, VLE shares community links at events.",
      cons: "Groups are usually invite-only from events.",
      bestFor: "After your first in-person meetup.",
    },
    {
      appId: "playtomic",
      name: "Playtomic",
      pros: "Padel culture is huge; easy to find beginner matches.",
      cons: "Court booking needed at peak times.",
      bestFor: "Week 2 sport layer.",
    },
    {
      appId: "facebook_groups",
      name: "Facebook Groups",
      pros: "Active Valencia newcomer and neighbourhood groups; events posted daily.",
      cons: "Requires joining the right groups; quality varies.",
      bestFor: "Finding hobby and neighbourhood communities before your first week.",
    },
  ],
  conversationScripts: [
    {
      situation: "Introducing yourself at a language exchange",
      spanish: "Hola, soy [nombre]. Me acabo de mudar a Valencia.",
      english: "Hi, I'm [name]. I just moved to Valencia.",
    },
    {
      situation: "Suggesting beach or park plans",
      spanish: "¿Te apetece quedar en la playa o dar una vuelta por el Turia?",
      english: "Want to meet at the beach or walk through the Turia park?",
    },
    {
      situation: "When you don't understand",
      spanish:
        "Perdona, mi español va despacio. ¿Puedes decirlo de otra forma?",
      english: "Sorry, my Spanish is slow. Can you say it another way?",
    },
    {
      situation: "Asking to meet again",
      spanish: "Lo he pasado muy bien. ¿Quedamos otro día en Ruzafa?",
      english: "I had a great time. Want to meet again in Ruzafa?",
    },
  ],
  localNuances: [
    "Valencia is more compact than Madrid, repeating the same Ruzafa bar works faster.",
    "Fallas season (March) is social peak; August is quiet as locals leave.",
    "Beach culture means many plans are outdoor and informal.",
    "Valenciano is spoken but Spanish is enough for social life after moving abroad.",
    'Dinner is still late; "tomar algo" often means drinks + tapas first.',
  ],
  languageBridge: {
    heading: "Stop feeling alone in Spain. Start feeling at home",
    body: "Valencia rewards consistency, and Fluoverse helps you keep showing up. Practice the scripts above, learn local cultural context, and stay in conversation between events so your second Ruzafa visit feels like a routine, not a gamble.",
  },
  faqs: [
    {
      question: "How to make friends in Valencia?",
      answer:
        "Start with a weekly language exchange in Ruzafa or Benimaclet, add a beach or padel group in week two, and return to the same event until faces feel familiar. Valencia rewards consistency over trying everything once.",
    },
    {
      question: "Is Valencia good if you moved abroad who feel lonely?",
      answer:
        "Yes, it's smaller and neighborhood-based. Ruzafa and Benimaclet have active newcomer communities. Consistency at one weekly event matters more than trying everything.",
    },
    {
      question: "Where do people who moved abroad meet in Valencia?",
      answer:
        "Ruzafa and El Carmen for language exchanges, Malvarrosa for beach sports, and Turia for running groups. Meetup and InterNations list most recurring events.",
    },
    {
      question: "How long to make friends in Valencia?",
      answer:
        "Many people who moved abroad report meaningful connections by weeks 4 to 8 if they repeat the same language exchange or sport group weekly.",
    },
  ],
  breadcrumbs: valenciaBreadcrumbs,
  relatedLinks: [
    {
      label: "Social apps if you moved abroad in Spain",
      href: "/guides/social-apps-expats-spain-2026",
      description: "WhatsApp, Meetup, and what works in 2026.",
    },
    {
      label: "Madrid social calendar",
      href: `${GUIDE_BASE}/madrid`,
      description: "Compare with Madrid's international scene.",
    },
    {
      label: "Spain social guide",
      href: GUIDE_BASE,
      description: "Month-by-month plan for all of Spain.",
    },
  ],
};
export const socialAppsGuideData = {
  path: "/guides/social-apps-expats-spain-2026",
  title: "Best Social Apps in Spain to Make Friends (2026)",
  description:
    "Stop feeling alone in Spain. Start feeling at home. Best social apps ranked for making real friends: WhatsApp, Meetup, Fluoverse, Facebook Groups, and more for expats in 2026.",
  keywords: [
    "best social apps in Spain",
    "apps to make friends in Spain",
    "best apps to meet people in Spain",
    "expat apps Spain",
    "social apps Spain 2026",
    "WhatsApp groups Spain",
    "Meetup Spain friends",
    "feel at home Spain app",
  ],
  heroTitle: "Best social apps in Spain",
  heroAccent: "ranked for 2026",
  heroEyebrow: "Social apps · Spain 2026",
  intro:
    "Best social apps in Spain for making friends: WhatsApp, Meetup, Facebook Groups, Telegram, and more. We ranked what actually leads to real plans, with honest pros and cons for people who moved abroad in 2026.",
  whatsAppSection: {
    heading: "WhatsApp: social infrastructure, not just messaging",
    points: [
      'Plans are confirmed hours before, "quedamos a las 20:30" is normal.',
      "You usually get invited to groups after attending a language exchange or Meetup in person.",
      "Voice notes are common; do not overthink perfect grammar.",
      "Mute large groups but reply to one thread when you can, visibility builds familiarity.",
    ],
  },
  rankingNote:
    "We ranked the best social apps in Spain by one question: what actually turns strangers into friends? Fluoverse tops the list because it covers the full journey: shared interests, continuous connection, language, and culture.",
  apps: [
    {
      appId: "fluoverse" as const,
      name: "Fluoverse",
      pros: "The only app built for the full path from just landed to feeling at home. Find activities with people who share your interests, learn language and culture for real life, and keep interacting until strangers become friends. Not just event discovery.",
      cons: "That you haven't signed up YET!!",
      bestFor:
        "Turning new acquaintances into friends you see again.",
      url: "https://fluoverse.com/#download",
      channel: "event" as const,
      highlight: true,
    },
    {
      appId: "meetup" as const,
      name: "Meetup",
      pros: "Best discovery layer for language exchanges, newcomer nights, padel, and running groups.",
      cons: "Event quality varies; commit to one recurring group, not ten one-offs.",
      bestFor: "Week 1 to 4 in any Spanish city.",
      url: "https://www.meetup.com/find/?keywords=expat&location=es--spain",
      channel: "meetup" as const,
    },
    {
      appId: "whatsapp" as const,
      name: "WhatsApp",
      pros: "Where real plans happen after you meet someone once.",
      cons: "No public directory, you earn access through events.",
      bestFor: "Week 3+ after first in-person contact.",
      url: "https://www.whatsapp.com/",
      channel: "whatsapp" as const,
    },
    {
      appId: "playtomic" as const,
      name: "Playtomic",
      pros: "Padel is Spain's #1 social sport; book matches at your level.",
      cons: "Learning curve if you never played.",
      bestFor: "Week 2 hobby layer in Madrid, Valencia, Barcelona.",
      url: "https://playtomic.com/",
      channel: "event" as const,
    },
    {
      appId: "facebook_groups" as const,
      name: "Facebook Groups",
      pros: "Massive city and interest-based communities; events posted daily.",
      cons: "Requires joining the right groups; notification noise.",
      bestFor: "Finding niche hobby and neighbourhood groups from day one.",
      url: "https://www.facebook.com/",
      channel: "event" as const,
    },
    {
      appId: "telegram" as const,
      name: "Telegram",
      pros: "Large city-wide newcomer channels; good for event announcements.",
      cons: "Can feel anonymous, move to in-person quickly.",
      bestFor: "Finding event links in Madrid and Valencia.",
      url: "https://telegram.org/",
      channel: "telegram" as const,
    },
    {
      appId: "internations" as const,
      name: "InterNations",
      pros: "Professional international events; good for corporate relocations.",
      cons: "Can feel transactional; less depth than hobby groups.",
      bestFor: "First-month networking, not long-term circles.",
      url: "https://www.internations.org/",
      channel: "event" as const,
    },
  ],
  cityLinks: [
    { city: "Madrid", href: `${GUIDE_BASE}/madrid` },
    { city: "Valencia", href: `${GUIDE_BASE}/valencia` },
  ],
  faqs: [
    {
      question: "What are the best social apps to use in Spain?",
      answer:
        "Fluoverse for the full integration journey (shared activities, language and culture, staying in touch between events), then WhatsApp for plans, Meetup for events, Facebook Groups for communities, Telegram for announcements, and Playtomic for padel.",
    },
    {
      question: "What is the best app to make friends in Spain?",
      answer:
        "Fluoverse for going from just landed to feeling at home, Meetup for discovery, WhatsApp for actual plans, and Facebook Groups for niche communities. No app replaces showing up to the same language exchange twice.",
    },
    {
      question: "How do I find WhatsApp groups in Spain?",
      answer:
        "Attend language exchanges and international meetups, organizers often share group links on-site. Search Meetup for newcomer events in your city as a starting point.",
    },
    {
      question: "Are Facebook Groups useful for meeting people in Spain?",
      answer:
        "Yes. Search for your city plus 'newcomers', 'language exchange', or your hobby. Madrid and Barcelona have thousands of members in active groups. Join before you arrive to get a feel for events.",
    },
  ],
  breadcrumbs: [
    { name: "Home", href: "/" },
    { name: "Guides", href: GUIDE_BASE },
    {
      name: "Social Apps Spain 2026",
      href: "/guides/social-apps-expats-spain-2026",
    },
  ],
};
export const intercambioMadridData = {
  path: "/guides/intercambio-idiomas-madrid",
  title: "Best Language Exchanges in Madrid to Make Friends (2026)",
  description:
    "Stop feeling alone in Spain. Start feeling at home. Best language exchanges in Madrid for expats who want real friends: weekly schedules, neighborhoods, and beginner tips.",
  keywords: [
    "language exchange Madrid",
    "best language exchange Madrid",
    "language exchanges Madrid friends",
    "language exchange Madrid beginners",
    "meet people Madrid expat",
    "feel at home Madrid",
  ],
  heroTitle: "Best language exchanges in Madrid",
  heroAccent: "(2026 guide)",
  heroEyebrow: "Language exchange · Madrid 2026",
  intro:
    "Best language exchanges in Madrid for making friends: structured weekly events in Centro, Lavapiés, and Malasaña where newcomers practice Spanish and English in rotation.",
  exchanges: [
    {
      name: "Language Exchange Madrid (LEM)",
      schedule: "Thursday, 20:00",
      neighborhood: "Centro (Sol) , La Fontana de Oro",
      vibe: "Madrid's largest weekly language exchange, 600+ people/month, structured rotations.",
      url: "https://www.meetup.com/intercambio-de-idioma-en-madrid/",
      channel: "meetup" as const,
      imageUrl: IMG.madridLem.url,
      imageAlt: IMG.madridLem.alt,
      source: IMG.madridLem.source,
    },
    {
      name: "Thursdays Language Exchange , Beer Station",
      schedule: "Thursday, 20:00",
      neighborhood: "Callao / Santo Domingo",
      vibe: "Oldest active Madrid group, very international, free entry.",
      url: "https://www.meetup.com/language-exchange-madrid/",
      channel: "meetup" as const,
      imageUrl: IMG.madridBeerStation.url,
      imageAlt: IMG.madridBeerStation.alt,
      source: IMG.madridBeerStation.source,
    },
    {
      name: "Sunday Language Exchange , Beer Station",
      schedule: "Sunday, 19:30",
      neighborhood: "Centro",
      vibe: "Relaxed Sunday crowd, newbies especially welcome.",
      url: "https://www.meetup.com/language-exchange-madrid/",
      channel: "meetup" as const,
      imageUrl: IMG.madridBeerStationSunday.url,
      imageAlt: IMG.madridBeerStationSunday.alt,
      source: IMG.madridBeerStationSunday.source,
    },
  ] satisfies ExchangeListing[],
  tips: [
    "Arrive 15 minutes early, organizers notice and introduce newcomers.",
    "Prepare a 30-second intro in Spanish and English.",
    "Stay for the full rotation; leaving early misses the second wave of people.",
    "Get one WhatsApp before you leave, quality over quantity.",
    "Return to the same language exchange three weeks in a row before trying another.",
  ],
  scripts: madridGuideData.conversationScripts,
  faqs: [
    {
      question: "What is a language exchange?",
      answer:
        "A language exchange event where Spanish speakers and learners practice both languages in rotation, usually in a bar or café, often free except for your drink.",
    },
    {
      question: "Do I need fluent Spanish for Madrid language exchanges?",
      answer:
        'No. Most events welcome A2 to B1 levels. Say "Estoy aprendiendo" and people adjust.',
    },
    {
      question: "Which Madrid language exchange is best for beginners?",
      answer:
        "Language Exchange Madrid (LEM) on Thursdays for structure and volume; Beer Station Sunday nights for a relaxed first-timer crowd.",
    },
  ],
  breadcrumbs: [
    { name: "Home", href: "/" },
    { name: "Guides", href: GUIDE_BASE },
    { name: "Madrid", href: `${GUIDE_BASE}/madrid` },
    {
      name: "Language exchanges Madrid",
      href: "/guides/intercambio-idiomas-madrid",
    },
  ],
  relatedLinks: [
    { label: "Full Madrid social calendar", href: `${GUIDE_BASE}/madrid` },
    {
      label: "Social apps in Spain",
      href: "/guides/social-apps-expats-spain-2026",
    },
  ],
};
