;; Authenticity Guarantee Contract
;; Provides authenticity guarantees for jewelry pieces

(define-constant ERR_UNAUTHORIZED (err u400))
(define-constant ERR_NOT_FOUND (err u401))
(define-constant ERR_INVALID_GUARANTEE (err u402))
(define-constant ERR_ALREADY_GUARANTEED (err u403))

;; Data structures
(define-map authenticity-guarantees
  { guarantee-id: uint }
  {
    piece-id: uint,
    guarantor: principal,
    guarantee-type: (string-ascii 50),
    coverage-amount: uint,
    guarantee-date: uint,
    expiry-date: uint,
    terms: (string-ascii 500),
    is-active: bool
  }
)

(define-map piece-guarantees { piece-id: uint } uint)
(define-data-var next-guarantee-id uint u1)

;; Issue authenticity guarantee
(define-public (issue-guarantee
  (piece-id uint)
  (guarantee-type (string-ascii 50))
  (coverage-amount uint)
  (validity-period uint)
  (terms (string-ascii 500))
)
  (let ((guarantee-id (var-get next-guarantee-id)))
    (asserts! (is-none (map-get? piece-guarantees { piece-id: piece-id })) ERR_ALREADY_GUARANTEED)
    (map-set authenticity-guarantees
      { guarantee-id: guarantee-id }
      {
        piece-id: piece-id,
        guarantor: tx-sender,
        guarantee-type: guarantee-type,
        coverage-amount: coverage-amount,
        guarantee-date: block-height,
        expiry-date: (+ block-height validity-period),
        terms: terms,
        is-active: true
      }
    )
    (map-set piece-guarantees { piece-id: piece-id } guarantee-id)
    (var-set next-guarantee-id (+ guarantee-id u1))
    (ok guarantee-id)
  )
)

;; Revoke guarantee
(define-public (revoke-guarantee (guarantee-id uint))
  (match (map-get? authenticity-guarantees { guarantee-id: guarantee-id })
    guarantee-data
    (begin
      (asserts! (is-eq (get guarantor guarantee-data) tx-sender) ERR_UNAUTHORIZED)
      (map-set authenticity-guarantees
        { guarantee-id: guarantee-id }
        (merge guarantee-data { is-active: false })
      )
      (ok true)
    )
    ERR_NOT_FOUND
  )
)

;; Get guarantee information
(define-read-only (get-guarantee (guarantee-id uint))
  (map-get? authenticity-guarantees { guarantee-id: guarantee-id })
)

;; Get guarantee by piece ID
(define-read-only (get-piece-guarantee (piece-id uint))
  (match (map-get? piece-guarantees { piece-id: piece-id })
    guarantee-id
    (map-get? authenticity-guarantees { guarantee-id: guarantee-id })
    none
  )
)

;; Check if guarantee is valid
(define-read-only (is-guarantee-valid (guarantee-id uint))
  (match (map-get? authenticity-guarantees { guarantee-id: guarantee-id })
    guarantee-data
    (and
      (get is-active guarantee-data)
      (> (get expiry-date guarantee-data) block-height)
    )
    false
  )
)
