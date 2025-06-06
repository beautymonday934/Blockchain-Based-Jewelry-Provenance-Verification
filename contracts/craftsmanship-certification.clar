;; Craftsmanship Certification Contract
;; Certifies jewelry craftsmanship and quality

(define-constant ERR_UNAUTHORIZED (err u300))
(define-constant ERR_NOT_FOUND (err u301))
(define-constant ERR_INVALID_JEWELER (err u302))
(define-constant ERR_ALREADY_CERTIFIED (err u303))

;; Data structures
(define-map jewelry-pieces
  { piece-id: uint }
  {
    jeweler-id: uint,
    piece-type: (string-ascii 50),
    gemstone-ids: (list 10 uint),
    metal-type: (string-ascii 30),
    metal-purity: uint,
    craftsmanship-grade: (string-ascii 10),
    creation-date: uint,
    certification-date: (optional uint),
    certified-by: (optional principal)
  }
)

(define-map certifications
  { certification-id: uint }
  {
    piece-id: uint,
    certifier: principal,
    quality-score: uint,
    craftsmanship-notes: (string-ascii 500),
    certification-date: uint,
    valid-until: uint
  }
)

(define-data-var next-piece-id uint u1)
(define-data-var next-certification-id uint u1)

;; Create a new jewelry piece
(define-public (create-jewelry-piece
  (jeweler-id uint)
  (piece-type (string-ascii 50))
  (gemstone-ids (list 10 uint))
  (metal-type (string-ascii 30))
  (metal-purity uint)
)
  (let ((piece-id (var-get next-piece-id)))
    (map-set jewelry-pieces
      { piece-id: piece-id }
      {
        jeweler-id: jeweler-id,
        piece-type: piece-type,
        gemstone-ids: gemstone-ids,
        metal-type: metal-type,
        metal-purity: metal-purity,
        craftsmanship-grade: "ungraded",
        creation-date: block-height,
        certification-date: none,
        certified-by: none
      }
    )
    (var-set next-piece-id (+ piece-id u1))
    (ok piece-id)
  )
)

;; Certify craftsmanship
(define-public (certify-craftsmanship
  (piece-id uint)
  (quality-score uint)
  (craftsmanship-grade (string-ascii 10))
  (notes (string-ascii 500))
  (validity-period uint)
)
  (match (map-get? jewelry-pieces { piece-id: piece-id })
    piece-data
    (begin
      (asserts! (is-none (get certification-date piece-data)) ERR_ALREADY_CERTIFIED)
      (let ((certification-id (var-get next-certification-id)))
        (map-set certifications
          { certification-id: certification-id }
          {
            piece-id: piece-id,
            certifier: tx-sender,
            quality-score: quality-score,
            craftsmanship-notes: notes,
            certification-date: block-height,
            valid-until: (+ block-height validity-period)
          }
        )
        (map-set jewelry-pieces
          { piece-id: piece-id }
          (merge piece-data {
            craftsmanship-grade: craftsmanship-grade,
            certification-date: (some block-height),
            certified-by: (some tx-sender)
          })
        )
        (var-set next-certification-id (+ certification-id u1))
        (ok certification-id)
      )
    )
    ERR_NOT_FOUND
  )
)

;; Get jewelry piece information
(define-read-only (get-jewelry-piece (piece-id uint))
  (map-get? jewelry-pieces { piece-id: piece-id })
)

;; Get certification information
(define-read-only (get-certification (certification-id uint))
  (map-get? certifications { certification-id: certification-id })
)

;; Check if certification is valid
(define-read-only (is-certification-valid (certification-id uint))
  (match (map-get? certifications { certification-id: certification-id })
    cert-data
    (> (get valid-until cert-data) block-height)
    false
  )
)
