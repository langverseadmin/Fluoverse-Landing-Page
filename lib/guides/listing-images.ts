/** Cover images from the listing pages we link to (Meetup og:image, etc.) */
export const MEETUP_LISTING_IMAGES = {
  madridLem: {
    url: "https://secure.meetupstatic.com/photos/event/7/0/2/6/600_517048710.jpeg",
    alt: "Language Exchange Madrid (LEM) at La Fontana de Oro, Meetup listing photo",
    source: "Meetup",
  },
  madridBeerStation: {
    url: "https://secure.meetupstatic.com/photos/event/a/3/2/2/600_450761762.jpeg",
    alt: "Spanish & International Friends in Madrid at Beer Station, Meetup listing photo",
    source: "Meetup",
  },
  madridBeerStationSunday: {
    url: "https://photos2.meetupstatic.com/photos/event/a/2/f/a/600_292781722.jpeg",
    alt: "Sunday language exchange at Beer Station Madrid, Meetup event photo",
    source: "Meetup",
  },
  valenciaVle: {
    url: "https://secure.meetupstatic.com/photos/event/6/c/0/7/600_534447655.jpeg",
    alt: "Valencia Language Exchange at Big Ben, Meetup listing photo",
    source: "Meetup",
  },
  valenciaBenditaBirra: {
    url: "https://secure.meetupstatic.com/photos/event/b/2/8/7/600_521085703.jpeg",
    alt: "Language Exchange Bendita Birra, Blasco Ibañez, Meetup listing photo",
    source: "Meetup",
  },
} as const;

export type CityImageSet = {
  hero: { src: string; alt: string };
  empathy: { src: string; alt: string };
  success: { src: string; alt: string };
};

/** Real city photos for Madrid and Valencia guide pages */
export const CITY_IMAGES: Record<"madrid" | "valencia", CityImageSet> = {
  madrid: {
    hero: {
      src: "/guides/cities/madrid-gran-via.jpg",
      alt: "Gran Vía and the Metrópolis building in Madrid",
    },
    empathy: {
      src: "/guides/cities/madrid-retiro.jpg",
      alt: "El Retiro park and lake in Madrid",
    },
    success: {
      src: "/guides/cities/madrid-plaza-mayor.jpg",
      alt: "Plaza Mayor in Madrid",
    },
  },
  valencia: {
    hero: {
      src: "/guides/cities/valencia-cac.jpg",
      alt: "City of Arts and Sciences, Valencia",
    },
    empathy: {
      src: "/guides/cities/valencia-turia.jpg",
      alt: "Modern architecture in Valencia city centre",
    },
    success: {
      src: "/guides/cities/valencia-malvarrosa.jpg",
      alt: "Malvarrosa beach, Valencia",
    },
  },
};

export const CITY_HERO_IMAGES = {
  madrid: CITY_IMAGES.madrid.hero,
  valencia: CITY_IMAGES.valencia.hero,
  spainHub: {
    src: "/guides/cities/madrid-gran-via.jpg",
    alt: "Spanish city street, starting point for city guides",
  },
} as const;

/** Fluoverse app scenario screens, only beside practice/scripts sections */
export const FLUOVERSE_SCENARIO_IMAGES = {
  restaurant: {
    src: "/benefits/Restaurant.png",
    alt: "Fluoverse app, practising a restaurant conversation scenario",
  },
  supermarket: {
    src: "/benefits/Supermarket.png",
    alt: "Fluoverse app, practising an everyday errand conversation scenario",
  },
} as const;

/** Homepage illustrations used on Spain hub only */
export const STORY_IMAGES = {
  connectWithLocals: {
    src: "/step3.png",
    alt: "Connect with locals, step 3 from the Fluoverse journey",
  },
  afterFluoverse: {
    src: "/after.png",
    alt: "After Fluoverse, building friendships and connecting with locals",
  },
} as const;

export function listingImageAlt(
  alt: string | undefined,
  fallback: string,
): string {
  return alt ?? fallback;
}
